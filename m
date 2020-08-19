Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8287524A9DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSXOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 19:14:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:29688 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbgHSXOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 19:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597878866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBJGqvhPFWeLvLAF22/2kD/hkzv3XkZfr4LIYWUJQTg=;
        b=EGxxrGLDYozviEsnfN09OFKEpXHhsxpBGo6Kv02vktLJ6UAEqUgyASC2vhl8vOVgiGwnb0
        8T9i397LSq6fHuSyCkNHYMUyxxuEfvFcznUXDWwtRK3gEs4GVd+vgpx5qwVQkoTJQIqeVu
        Xq7oOoJ7R8MTA2mw47JOao5B54yV5y4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-VF4OpkpYOCq1hhZLE_N8Pw-1; Thu, 20 Aug 2020 01:14:24 +0200
X-MC-Unique: VF4OpkpYOCq1hhZLE_N8Pw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNiwQsnGeQAyH4biHKwZkxqu2/vjffsno7/UvGxBZ/YXQnoNSb3vtP4g+GefdDpah3d0rs6FHLh9zW2lBooWiBiB0c2AcqXSzH9L84n07bLlD5y37KYDn/F1nKaF6DF1H/jb+gOKQAHyVR3sU2RTfpC8Dh5hex8ML/yEDsHypZVbWs3eLOuSPDdPjbVFj4m5vDPKJsPmIXxRCvBoDhFfJgdU9QVqTothex+vgyldwI2IH72uOGy7hvlcsp5ZpVoFKVbiqORhn4VeGTlIOMxxL/mwUV5++1VHc/EXcaBQVpzjP77kioG3xbyVfFhCIReZDrSHFvenlZe1ny9rzMwnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz09EP7ChO5llXtldYiBloP3Fy1QWwljzcyfDBa6gS8=;
 b=QU9Q4vxR0Sk136dP4O4H01Dx3lS1vag6zyIyFS1j2bvQ4dEy/yt4js91EvGRFQurkDarJxASRoGKKHPoBaG9BEI8baluOJD/eyH+zXNq2AqxDvjWXu6GhFrZjRazQeq9PqcisrK0Vrx5YG3YyJTUtNnDU3cbEYOgOtkHIBgYFEkXWvvAyzP9f6BdyN1eGKeiXmYHYfOMCDYDSZHPgFU77YrT7+hHAafAOyJxsO9hN27Hwdf9ERltHdqHaNthCWEXpyUj6ecoOyMqB2ai7ctJcl22Z9JmKR07Tn1zsLYNTre4D0aiV7mRCY9IV9lJ3fv/P64HUsx9b3prGSQK5s7nYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4980.eurprd04.prod.outlook.com (2603:10a6:208:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 23:14:23 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 23:14:22 +0000
Subject: Re: [PATCH v5 1/4] btrfs: extent_io: do extra check for extent buffer
 read write functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200819063550.62832-1-wqu@suse.com>
 <20200819063550.62832-2-wqu@suse.com> <20200819171159.GT2026@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <66f629fa-e636-6ab5-eda8-5299d996b2f4@suse.com>
Date:   Thu, 20 Aug 2020 07:14:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200819171159.GT2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 23:14:20 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d153937e-6fc0-4fbe-645b-08d844959b7e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4980:
X-Microsoft-Antispam-PRVS: <AM0PR04MB498080238A611A25E3B28430D65D0@AM0PR04MB4980.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TC1nAIrMa5neBIZDctrMbHkO+y2cOOupcdOwOHd/mAuZ3bXdAKiphw/brLdaHQW7QHej+C6kak8CNBr4CJ5JElHI4Qb8QemHnzR0+SmbyvmB34j94/oxe5DvgoFh26B4kH2VI/SCAkHGP9GVRaP+N1pvtPRBOgwcVSEMaaSAAXPHlfLzWnA+hqU1H8ItYSzEVCYxZRHuhYbgIKnRmQ7K5mv66MbivGzxOVKQQJ7Er6T3/6daF2PoesaPsWuabOhT3LfECgUEGRDPLNIxNVR8t6SJiRycdVP3iSiqE9Yl2eI87AehPs8Mwhlzbk9CyIHwz7urdnaMxFVrAQth6IKWvJO6UKzk/zgYJ80+MOYS76KEvwNdEAWhlK0p11ZeY9fqEbG3ojVnUILVVXHBMCyiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39860400002)(346002)(8676002)(6486002)(186003)(2906002)(52116002)(16576012)(956004)(2616005)(316002)(6666004)(31686004)(8936002)(16526019)(6706004)(31696002)(66556008)(5660300002)(66946007)(6916009)(66476007)(36756003)(26005)(478600001)(83380400001)(86362001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w5Kk1pOG7Z0vXp0JU5w87YNZaghlSLnpf5Pz2j3bC3EI7T7bhbJEJrD9XLrlda/EsKcPNIibBZXqEeMIz/08P3DxCho00dIRXNgrse+MqIJoiAYJaTnT9r7Mzf/Lt1DRV20V6j3w3UMR1s2U1FXWmpW7a4RhKMOoNIZbhGklZs1UqZ7QNp5LthOLaiT94PAqSitSUSLMNzNsfDec+klSy4HQY+hrx5xdga3DpT36zRVOUgvuxpQKFHSdc6WKyBfM1IqSS5wwRowtgIXfLFKbBSbjrhxjNhqUpSJRpkUhLq6V7byoABixdg1t+TYnKG5FEU28L0Ga+kKVOW0N09r9z1jPpqKI7xoiKpfDp4qtLehGCjd1BkEOVs1gVE9geJLhY0E1lkeapDcv5irsx5TBEOoKkffFaIR97kSJnkb5pbXejKM7SuV1pvruyplKb7xyd2TZyuKAjiz3bGNPn4laaHYRdGEEI/dvYHAUGbxRT59vKONPvEmMZv/fdhO9czxj1kosobGB0iWnVqmZi1N4BK9qRGsVVZpovtFUdeXyMuLmd4y49y7pQrB8rmyIE+THpxxltxqW6DKKakpVBPWin2cFfNsBjHwf9ZprAPpi9gNBsOLmfuA9+e7H2ZI3yreot+Uq7kkT1YVh7GNPUrBXDw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d153937e-6fc0-4fbe-645b-08d844959b7e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 23:14:22.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMljY+R+jKk0c06GNzSMHEZVK+i3uAJfSsIYqEiptQWHhhC9Qeu9PmAznHT5mpXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4980
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/20 =E4=B8=8A=E5=8D=881:11, David Sterba wrote:
> On Wed, Aug 19, 2020 at 02:35:47PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5620,6 +5620,34 @@ int read_extent_buffer_pages(struct extent_buffer=
 *eb, int wait, int mirror_num)
>>  	return ret;
>>  }
>> =20
>> +static void report_eb_range(const struct extent_buffer *eb, unsigned lo=
ng start,
>> +			    unsigned long len)
>> +{
>> +	btrfs_warn(eb->fs_info,
>> +"btrfs: bad eb rw request, eb bytenr=3D%llu len=3D%lu rw start=3D%lu le=
n=3D%lu\n",
>=20
> No "btrfs:" prefix needed, no "\n" at the end of the string.

Oh sorry, should re-check the message.

> The format
> now uses the 'key=3Dvalue' style, while we have the 'key value' in many
> other places, this should be consistent.

Indeed, I just checked tree-checker, which does use 'key value'.

>=20
>> +		   eb->start, eb->len, start, len);
>> +	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +}
>> +
>> +/*
>> + * Check if the [start, start + len) range is valid before reading/writ=
ing
>> + * the eb.
>> + * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical addr=
ess.
>> + *
>> + * Caller should not touch the dst/src memory if this function returns =
error.
>> + */
>> +static inline int check_eb_range(const struct extent_buffer *eb,
>> +				 unsigned long start, unsigned long len)
>> +{
>> +	/* start, start + len should not go beyond eb->len nor overflow */
>> +	if (unlikely(start > eb->len || start + len > eb->len ||
>> +		     len > eb->len)) {
>=20
> Can the number of condition be reduced? If 'start + len' overflows, then
> we don't need to check 'start > eb->len', and for the case where
> start =3D 1024 and len =3D -1024 the 'len > eb-len' would be enough.

I'm afraid not.
Although 'start > eb->len || len > eb->len' is enough to detect overflow
case, it no longer detects cases like 'start =3D 2k, len =3D 3k' while
eb->len =3D=3D 4K case.

So we still need all 3 checks.

Thanks,
Qu

>=20
>> +		report_eb_range(eb, start, len);
>> +		return -EINVAL;
>=20
> This could be simply
>=20
> 		return report_eb_range(...);
>=20
> It's not a big difference though, compiler produces the same code.
>=20

