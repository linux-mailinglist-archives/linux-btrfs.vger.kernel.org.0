Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDD3B82BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhF3NPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:15:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32401 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234679AbhF3NPn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625058794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8LppranZZWKSV35YW+ohTfGxrwAlzsrOM7jSi/rxL8=;
        b=jFw7ot2e7D8OmTY2wElBh07nmGs3vngobntLqNKSbOGM5VcbKDwVNFZ+NJ/M7KP8iBlbak
        mcYN+lfj1HrQP0IJOxC38UivBtbEhChf98osJ+bRStHBGGHAbp27gaEneCXjKoxWYBeZND
        v1OhhZr3URSu+R5yn4vn7sAnCY9ZJDA=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-jh1Lz_luMvCv6aXeiuX75w-1; Wed, 30 Jun 2021 15:13:12 +0200
X-MC-Unique: jh1Lz_luMvCv6aXeiuX75w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUHtbLvwRu7DiYBZ3mdsJ/KaI3hagRnJNipX29yQsgED4mp4IKQeXgFNq+JoMg/HN02D0DU1Irg95UhOjkC4lRhC18ej17j89wDutEp8Xzq5bXWFqXr0OAEcN6x5SyOgWfZyZohP+SsUu47SAkKbYqqW2FGcVDYmGJ4jARTWsebyhP0lBZc5ZoPRp7bQdpgYZZWGyGrPtZWDiGWv5trA39b8Ca8pgE7+EgdF9UN0sujmQ7brkxpt8Uldfxpwi6v100Avl9OmWlLmhvsq03BgNQQLc9HfTmrWaFT9rR+nxiKFORwF/wF2EnkePDkTNQyh3x4jzn3DQZ6k4C8hxjRqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ExKrkfZOHSlb/D7Vg7cbHtscp0IiBmDXxC6IpCj/5I=;
 b=Dnjmvd2XQGKNH1N0mRtlpdnJ08x+gBbpl/Bnka9gV01JXEJbYAwsi43S1/1xoT4Wc/DK0e+2SHFfK3jfN3hYz+QW8nKOTw0Fs2D0sO7IGGApEtiFB7pIrjI9dvv6Wyd6H23qa+jl4GSrqpR+c0E1mUN6S7/C0icwjPZSYOUtkZEp2tBrKrkIhpC0z43polhHpdSu+kbexZI4BK6DWekgXjsJ+hwRwavF42WSjgrwSxNs606EymxfYUzYR513YGZSXONp5X+SRlhf+KGzuFc/H1xPQ3z98z3nvmU9lMtccZ5XC/V1FRb2WhL9GrMfBADhrpwZhdow2cCN23geZurUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8310.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 13:13:11 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 13:13:11 +0000
Subject: Re: [PATCH 2/4] btrfs: remove the GFP_HIGHMEM flag for compression
 code
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210630093233.238032-1-wqu@suse.com>
 <20210630093233.238032-3-wqu@suse.com> <20210630130636.GK2610@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <5fb9c721-5aee-bc1b-5d80-6585cfc9cb7e@suse.com>
Date:   Wed, 30 Jun 2021 21:13:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630130636.GK2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0024.namprd17.prod.outlook.com (2603:10b6:a03:1b8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 13:13:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23ea727-c00b-4593-7e85-08d93bc8cf60
X-MS-TrafficTypeDiagnostic: AS8PR04MB8310:
X-Microsoft-Antispam-PRVS: <AS8PR04MB8310365298CE372475D5D6B3D6019@AS8PR04MB8310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmTQ1rEuRqtMbwmijWl+Xys2lPcLHxzJai5DrkIcAXn0CBsuntcHrzb1Sm93o3ioiEDGr+P6upQAr2UBSFtpbSCtIqkJ5u2I+u/knKLGYwxdLAME7a9dtdoigN4CGA7J8pp0n9ZEqFCNDR1babyDLu+q1FLAYNX5Cng2xQ3zscnTvwvaD8buBe+guP5ik6/RCFn5qJjrKm7fDi4bE4Q0yfTVCH2/agsUI6HH8EQj9MvQ4Vxn5h6Vl4YDCn8NWe8in0Y7M+4/oAXMGLIMIj8zQ+TnkPZTpBhaEwkokj98fD1qfRmTc3R0AzpFoSu5Omvqswy/fhCQVPmcGol8pvlPvLiImaCdd9prEy/C6H7dnVEQV/X4ngqqIPjNpNNlUGXNQalmss4V9m1H6K8aA0N63YX7dZtAHtt6Bg0f+OgXVh9jZV2QsikAuZFQfYTGkeFrGhSQh2mVbnOGMdlo0wspnf7j+kxj+merixZjeZ1gqg+riPB4os0nA+5QHtrUq81v1f5mDQABgjYIdBALJoEXSr14Mj6f3BUq9C6AXPWJfkeemgFevif3NhdX8apUMRHrfTMb3p+EmSp+xgOi4g7MjMygHp6xyIv28uXZfyf/hx/2El1u7rg8lBAQfSa4u4FThstyp1Ky9JGu7c7k+Ekf/aAkSWa0uwjjcm0bmzyEoeCGY8/EqyP0KwJ9xaTM1Gj6VZaZUEa6kg8/SXHpWneWN6sGBNC3j0Ov51iKgGK4zRkFuZlJjB448GugjotxasWt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39850400004)(346002)(366004)(86362001)(26005)(16576012)(83380400001)(31696002)(38100700002)(6666004)(316002)(6486002)(2616005)(31686004)(478600001)(66946007)(956004)(8936002)(5660300002)(66556008)(66476007)(6706004)(16526019)(2906002)(186003)(36756003)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HyOV+QbhaDJmrrcmT8rolLgDPKeXQRyECXV2dd8NHXhlInEpCTm++y6RxwpO?=
 =?us-ascii?Q?ZbQKiS14SHfXwA5jZ/iVyxJf+TDssOLiFKKFzY10efahslPeCyvVqgctWXE4?=
 =?us-ascii?Q?s0Kz1nYyj+1HU+oeR1KixYL90HT2tjvt7KV+XyM+Xmri8eXQpOk2ful1in+P?=
 =?us-ascii?Q?QBYgCRRguqKRoinatwLFvZ4US8L2uHyrhOPKYpGqjru2BUi6iiG/5Fu2aul4?=
 =?us-ascii?Q?hbMFnGTEp8TGBrpzbHZWCNMA9LWFywoU+K1Y52jgPhE4IXyYZ6NBs1mUpCP6?=
 =?us-ascii?Q?/hCairuku61N/K8lFrvleKbjagW1e7gtpNNDdpTAjbtpGx5FEyQrA0nBWclP?=
 =?us-ascii?Q?skwZrsmHY9tjufnYQmCZAP2791QYjEHMEFixogiYAKvmj5sYYS9Z5LNMSyK2?=
 =?us-ascii?Q?2SOmoNQt5Dvtk3Yiy3idmLSdxGozqfD5qxQqyIkdtfhYXgt88Yt6NsNLmDoy?=
 =?us-ascii?Q?ixBUMNpe8DHVGkTVYx3SsbjQv619J6+Sf8Bi4qNs4rBUTmwsDBLGTlr0y0Is?=
 =?us-ascii?Q?ca6wNK14s9ix8HbH9YiQHxGu7DqACROycFvZA0iNO+N2EM+nxz4rRE83sAv4?=
 =?us-ascii?Q?K9+qwvgFnnVhgkxGyahyJVami8PyDPfUiAel/3CioTVTDZVZgj+pOIxgeBKE?=
 =?us-ascii?Q?nkyK+xKTVWhYufJYjTFsh2MIdUf6ZK4YpcmaH0nZikA+wse2h8Kaby4t/VSJ?=
 =?us-ascii?Q?1+sF/uYySL5P33IOZ1c6O+8TtEhBzN7htIUC6/Hrzl3068tmYMMe+akId9ig?=
 =?us-ascii?Q?KAQc30Lv0wf4g3rmYV0cK0nZ+tVeefYzoKmkyhU1tR2isItXKB46vBi+7XWE?=
 =?us-ascii?Q?VGF6Hcwwfi0JIn7dI1LnoLJvxZhcsbiu9PMDGWAKXFYK/xn+mubtjtvfQnnm?=
 =?us-ascii?Q?xkZ5LJf8wUUXmrw5muD/ZXdv60DkukGC48AWk/YyxNHEkhMKkpLhpuxZ/QRN?=
 =?us-ascii?Q?AlqX1tPa+R8h0Oltg8ccqJMzqEj85Yh2ZpNl12Wi+/IAwAJlF0R9zJuyhxqB?=
 =?us-ascii?Q?ay0ZoQzZsUkIOFnDpyKCu+BiVEFiWPLak1pcj3P6ufZuEpBGTMfHc6u1QS1o?=
 =?us-ascii?Q?J0clLGm21ibMBPaPiSOv1alAHby8I7++p/vfosPcy/0VKUjSrAhrzxZreVCc?=
 =?us-ascii?Q?LXXJWyA7dJwvGDGhlYoAsi6qtFLwozxGCscHPnJsHgC5xXxnMnCramKude49?=
 =?us-ascii?Q?IJ3kzRvQhW1E/1qGzcnF1crQnsQIESGmQtrFaskXXlmX2mGNiLdeFUye42Kz?=
 =?us-ascii?Q?Hjbnon7YgH6XsSqrnojXSrKtDRVSGZuCF8h7z3Ds1y47zAazRvqeI74XA/r3?=
 =?us-ascii?Q?74gif9TiyDOiL+TOQz/1bzr8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23ea727-c00b-4593-7e85-08d93bc8cf60
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 13:13:10.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMO3/UiGdbjfVYhkmc9tP3aFjD4HRuLy36ZRrAUS8HFwzdVx0oo4i1a7IaFQ0qs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/30 =E4=B8=8B=E5=8D=889:06, David Sterba wrote:
> On Wed, Jun 30, 2021 at 05:32:31PM +0800, Qu Wenruo wrote:
>> This allows later decompress functions to get rid of kmap()/kunmap()
>> pairs.
>>
>> And since all other filesystems are getting rid of HIGHMEM, it should
>> not be a problem for btrfs.
>>
>> Although we removed the HIGHMEM allocation, we still keep the
>> kmap()/kunmap() pairs.
>> They will be removed when involved functions are refactored later.
>=20
> Without removing the kmaps it's incomplete so I'll post the series
> removing it from the compression code at least.

But kmap()/kunmap() can still work on those pages, right?

This is just a preparation for the later patches which refactor=20
lzo_decompress_bio() and btrfs_decompress_buf2page().

Thus I don't think we need to do that in one go.

Thanks,
Qu
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 3 +--
>>   fs/btrfs/lzo.c         | 4 ++--
>>   fs/btrfs/zlib.c        | 6 +++---
>>   fs/btrfs/zstd.c        | 6 +++---
>>   4 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 19da933c5f1c..8318e56b5ab4 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -724,8 +724,7 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>>   		goto fail1;
>>  =20
>>   	for (pg_index =3D 0; pg_index < nr_pages; pg_index++) {
>> -		cb->compressed_pages[pg_index] =3D alloc_page(GFP_NOFS |
>> -							      __GFP_HIGHMEM);
>> +		cb->compressed_pages[pg_index] =3D alloc_page(GFP_NOFS);
>>   		if (!cb->compressed_pages[pg_index]) {
>>   			faili =3D pg_index - 1;
>>   			ret =3D BLK_STS_RESOURCE;
>> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
>> index cd042c7567a4..2bebb60c5830 100644
>> --- a/fs/btrfs/lzo.c
>> +++ b/fs/btrfs/lzo.c
>> @@ -146,7 +146,7 @@ int lzo_compress_pages(struct list_head *ws, struct =
address_space *mapping,
>>   	 * store the size of all chunks of compressed data in
>>   	 * the first 4 bytes
>>   	 */
>> -	out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +	out_page =3D alloc_page(GFP_NOFS);
>>   	if (out_page =3D=3D NULL) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> @@ -216,7 +216,7 @@ int lzo_compress_pages(struct list_head *ws, struct =
address_space *mapping,
>>   					goto out;
>>   				}
>>  =20
>> -				out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +				out_page =3D alloc_page(GFP_NOFS);
>>   				if (out_page =3D=3D NULL) {
>>   					ret =3D -ENOMEM;
>>   					goto out;
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index c3fa7d3fa770..2c792bc5a987 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -121,7 +121,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>   	workspace->strm.total_in =3D 0;
>>   	workspace->strm.total_out =3D 0;
>>  =20
>> -	out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +	out_page =3D alloc_page(GFP_NOFS);
>>   	if (out_page =3D=3D NULL) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> @@ -202,7 +202,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>   				ret =3D -E2BIG;
>>   				goto out;
>>   			}
>> -			out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +			out_page =3D alloc_page(GFP_NOFS);
>>   			if (out_page =3D=3D NULL) {
>>   				ret =3D -ENOMEM;
>>   				goto out;
>> @@ -240,7 +240,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>   				ret =3D -E2BIG;
>>   				goto out;
>>   			}
>> -			out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +			out_page =3D alloc_page(GFP_NOFS);
>>   			if (out_page =3D=3D NULL) {
>>   				ret =3D -ENOMEM;
>>   				goto out;
>> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
>> index 3e26b466476a..9451d2bb984e 100644
>> --- a/fs/btrfs/zstd.c
>> +++ b/fs/btrfs/zstd.c
>> @@ -405,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>  =20
>>  =20
>>   	/* Allocate and map in the output buffer */
>> -	out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +	out_page =3D alloc_page(GFP_NOFS);
>>   	if (out_page =3D=3D NULL) {
>>   		ret =3D -ENOMEM;
>>   		goto out;
>> @@ -452,7 +452,7 @@ int zstd_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>   				ret =3D -E2BIG;
>>   				goto out;
>>   			}
>> -			out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +			out_page =3D alloc_page(GFP_NOFS);
>>   			if (out_page =3D=3D NULL) {
>>   				ret =3D -ENOMEM;
>>   				goto out;
>> @@ -512,7 +512,7 @@ int zstd_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>>   			ret =3D -E2BIG;
>>   			goto out;
>>   		}
>> -		out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>> +		out_page =3D alloc_page(GFP_NOFS);
>>   		if (out_page =3D=3D NULL) {
>>   			ret =3D -ENOMEM;
>>   			goto out;
>> --=20
>> 2.32.0
>=20

