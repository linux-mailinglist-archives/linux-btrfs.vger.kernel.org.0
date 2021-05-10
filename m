Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB74E379AFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhEJX6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 19:58:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47304 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhEJX6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 19:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620691015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ7ZGxa3N6VlA0EkLljz4xlFBBJyG/bT+mL2wkY2cs4=;
        b=UwgnUx6EbUBbfk/rQgTYwyfui1XZvVjsmZPx22FzW/GMNJm3Qw+KE032nwBJoyxdS1iE3I
        WIKFwBj7Y3SCbnMP7xsZEd6QuNs6iRzMeO1q3dnyN3QQ2DuPfB91OtIIvQd4zO6Fi1D0lb
        EmxU6pn9pEW7vaZOt7Ey1/VEikax4gU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-wPD5vpk3N7qzcm9QE9OKNQ-1; Tue, 11 May 2021 01:56:54 +0200
X-MC-Unique: wPD5vpk3N7qzcm9QE9OKNQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzUS3rD/iHl1Q7a6aBjxf5hbgTzRPC5IdX+bkGZF4yChj4n8+ddZSCQMPTSBDW32RqG6gtypw17s0eu5twztek/xO2ASLIguVB0LZqPPXjexsnQ+5QfeOj1xytaFoMZWzqjQfOu+jABtY72Fiui+blvdF8lGmSxXQ5XDSGxSWnKwtOvSa1nzrs/8ZSAA+i02zeIPB7Lc0m2JcdpMe5V5nSpmt7kMPbZ/SJcdRG/wfChwCPACSo2DHP/CzsMI55Z/t7skKGxQWHa2XLZzwkIDC9oYc0NLoDoNsKI0iUE0hvF6UPSVvvJrvBBu0L1iQESR4vRRycd00jA42mmUixPLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjCSowAONadVbkI3QoKmaNDOJwS3ATfvpkhMrXx9Xvk=;
 b=dvHeFQBpP4rpxvpdr6fj08GEeeWsLKYzLedNd7KZbK6c0RXpBYtMQ+9pSH9iPkAOvfKOjEpzS7mEna1/7YUULPQWI1DcTxWfj+4sBZ4PsPN+CBfET0+UXFaVN5xKYrz8U2oLzcNLlLMWmi1f0kKhbsRkxRuAvdkaruUq6L6pOuyFU+0LkejNVfmgUqMNAISqT6stgZL1ncHW670Ubl3ujIjN8CX7Qb4cq9VSP/4MLWS01MJ2wJqpl6p0dT3HK5M2574h75jlZvzqcckjF1nzcDvfQnQ9LY04x/GDaxDpi50Bb8arfQu/9N0OGxWFhWNtGZyWclgD9uHmtoPRVqIdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5702.eurprd04.prod.outlook.com (2603:10a6:20b:b0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Mon, 10 May
 2021 23:56:52 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:56:51 +0000
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-2-wqu@suse.com> <20210510201431.GC7604@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 1/4] btrfs: remove the dead branch in
 btrfs_io_needs_validation()
Message-ID: <07444aed-81a3-4f1a-aaf4-e3462167383f@suse.com>
Date:   Tue, 11 May 2021 07:56:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210510201431.GC7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 23:56:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d653f99f-27ca-4881-2b54-08d9140f47ff
X-MS-TrafficTypeDiagnostic: AM6PR04MB5702:
X-Microsoft-Antispam-PRVS: <AM6PR04MB57020B9B3D70746F64A7E4E9D6549@AM6PR04MB5702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB3UFETzyHO4XMlMsGKoMyknEU3vzbmh6CEc9vMm1yaM7e+qootp1qw+vkd1ExMVATRmGUR1QLn2bTcXrJ5b16EP1Vtp8+BahEW9/+lPPldsXg+LoXHrZFbsMqRvp8C/OeOl01bHa69z+i7NFkgk5S4BI8b6KKGG0N5DRw9VbHd2Y+OcnSyI1pamVk7ENyPj/6QS/GyCR7zcB4GO/s1B9bmOJXGABZ0Z9crFJRSCV8QzMVkPcLVTcfrIL7C/FWLpKBiSi933rXtdqZjkNSL+Dwt/7mHvhhvPStwMTOXbVqEarnKX6CNpqn8QX+PjJe1XlAhNo00ZW92P/Jt4eLI18tMSflmwig4qCWaeoin7jSJ45RlX1E8BtH7IX1+e5ggDUgtV+OzyYvcfiiWWXO2A9bfPMj/GcfR50epR/034Js4BoxLQp2ax3rcwft9QTK7QNsGnBSqFsFPyn1wbkmDZaBrUawl8n+69jtU9BoqB7RHhfN5z8A3bXfsAldNKs95N1fh7xmfoViJMIptc/4DOJ0EPM9V99WtBPDG5yF2/FeppOfLHvIkpSFZxaTEeaVxAR99ZSxjkmJAxDDiClU6Utriy0Xb1D95aMSMgydA7iZCVgTMlJWVAaJC4i5j96xjiSW53DtcxkEjqnGE14cFP0qFdG0AEOy9zdRL/yXYQDfwkmBJschaYm/5K9u2VaiGXhnzmXTzaD75T91wt9r5QIrn0e2Ek+PzXRsq3RP2IOWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39850400004)(16526019)(186003)(5660300002)(36756003)(6666004)(31696002)(66476007)(31686004)(478600001)(2906002)(38100700002)(6486002)(66946007)(52116002)(83380400001)(8676002)(38350700002)(66556008)(26005)(8936002)(2616005)(16576012)(956004)(316002)(6706004)(86362001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?egXFUAQdiXN4Iy3tu1LH66yP4//cFn1Cmoaqr8HG7/7kDdp1YGCAolAool1n?=
 =?us-ascii?Q?cy/LNGyl3xBtNAcEYgO1S2mFRFKpi1BH0GFnWjVgYvvR8+go1W2vMDxltRNi?=
 =?us-ascii?Q?P2RAQM610Hcfd1EZfj+mZBtn+PFrgy8PjiICFAqD61v0aRsbML4kCiNf/uVO?=
 =?us-ascii?Q?/UqBFNrd0T9vXmgrGPbQAt42efXrNXgSx5kLkffDSyb9hO+CvB9xO88zenSt?=
 =?us-ascii?Q?kXOg70EBTba7xHOuWJxKkuM4U+l3c18Z6UsV0IaWcqr34bUhRehD7IvbcZjR?=
 =?us-ascii?Q?tDjvZTleI3uCnvpDyOEmdJwLfdLi3gqkF8qKrZCmngnf8y0VFuzGJ/ZcTsE6?=
 =?us-ascii?Q?sRhmTVzKuvoJQW94jSf0nCDQr8acqbKfE6stFdlc12wa0X+aO6FNLXuqBCwk?=
 =?us-ascii?Q?BUOhBqBa0208KHpYy4QlH9aBUAGSu/6dIy0w107aL+Yk++NvHi7Qmp8tOyOK?=
 =?us-ascii?Q?D2btqOJ0QmJb0mkL4w6F5pmb6pp/C7xt5bkSff7IbFaUkicu0knvbAGzqykK?=
 =?us-ascii?Q?jwY+ICDlSMkgVBpqtewY45Knjj5ToIHX/2ld2Ix3Cikh7C8KgABRIRUWIvAn?=
 =?us-ascii?Q?KFlZK1giiRI1O5EcFfzHxwvcUkrExlcJdoaSzer4KCR+p42AutosuKhWPrt7?=
 =?us-ascii?Q?N9wraFYZM1+GAFFbJi9EZiFgd39wXLlokSvI5uUatuSopKEaW9VxMPodh8Qe?=
 =?us-ascii?Q?1Apqq0tyZWMe1s/j3kuMCSYwJTNZRx0HYcnP/8MZv8LQHg48uexTS7cYiU+J?=
 =?us-ascii?Q?WOGXKuoDHWw4/1CodrRiHbTt2xI+LFSZEJFddOtAPY+ZHvFWtGdqmUT4A+UK?=
 =?us-ascii?Q?IfufzfDNs7FzagdpDb/OPaLnPacaiK/4pn9y4KmMZfDMFn588AxBahuTfwid?=
 =?us-ascii?Q?GGkplwzQrzdCDq+V1N3NRpFdkn/eimrbGvQrWkgSVIvuSUePvczLINFr8bEC?=
 =?us-ascii?Q?KAPKjxN0ts5hRR90byDa0J22j99/8G/hOYeXjgYskP7XPARTTJT37V+EXVnJ?=
 =?us-ascii?Q?EtX/C3o7V6Gjfi75LB6Xov7cO7N6MoHKoCKz3vc1IH4iPPFhaTKR5QUa/dVQ?=
 =?us-ascii?Q?YwI1NMDtVuAcVz+pAObgVJ7C7oj2xJPwf7A3AuWM8nEUdUS5eu+AuJXt8Qsl?=
 =?us-ascii?Q?7SlmeBJoC3I9o8V6SX4THHs253VeggbObsAKuy9++g7bEqXtmlza5tOhLtJB?=
 =?us-ascii?Q?ktayggMwlU97qPnC0R4NC3T1FU9/79raQlfx15ZrsaIZ6B0PJVjPM0kfZTDd?=
 =?us-ascii?Q?dbcWJW7SHZj2g7zNrvVkznxR5Pbzb8iD1W1cUpt6Yy0FFCoSvr7A2QkdF5aN?=
 =?us-ascii?Q?sb/DQdo+wdkeuwQZNXDaC+39?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d653f99f-27ca-4881-2b54-08d9140f47ff
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:56:51.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0KfWtGmO4pdcfjSsqiOrzAWxFIp/3xiTRhZn3etBCEEBeEWZVyennQrKCpO6Nmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5702
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8A=E5=8D=884:14, David Sterba wrote:
> On Mon, May 03, 2021 at 10:08:53AM +0800, Qu Wenruo wrote:
>>   	/*
>> -	 * We need to validate each sector individually if the failed I/O was
>> -	 * for multiple sectors.
>> -	 *
>> -	 * There are a few possible bios that can end up here:
>> -	 * 1. A buffered read bio, which is not cloned.
>> -	 * 2. A direct I/O read bio, which is cloned.
>> -	 * 3. A (buffered or direct) repair bio, which is not cloned.
>> -	 *
>> -	 * For cloned bios (case 2), we can get the size from
>> -	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
>> -	 * it from the bvecs.
>> +	 * We're ensured we won't get cloned bio in end_bio_extent_readpage(),
>> +	 * thus we can get the length from the bvecs.
>>   	 */
>> -	if (bio_flagged(bio, BIO_CLONED)) {
>> -		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
>> +	bio_for_each_bvec_all(bvec, bio, i) {
>> +		len +=3D bvec->bv_len;
>> +		if (len > blocksize)
>>   			return true;
>=20
> I've looked if the bio cloning is used at all so we could potentially
> get rid of all the BIO_CLONED assertions. There are still two cases:
>=20
> * btrfs_submit_direct calling btrfs_bio_clone_partial

This is what I missed.

In fact for DIO read repair we can still hit a cloned bio.

But in that case, we still don't need any validation since the DIO read=20
repair is ensured to only submit sector sized repair.
So the patchset is still fine, but will break the bisect.

> * btrfs_map_bio calling btrfs_bio_clone

This is not a problem, as the generated bio are for real device, not for=20
the inode pages, and read repair only happens for inode pages, we're=20
completely fine.

>=20
> So in this case I'd rather add an assertion before
> bio_for_each_bvec_all, as this fits the usecase "this never happens".
> The original assertions were added everywhere once the bio iteration
> behaviour changed without much notice, so we need to be cautious.
>=20
> Applied with the following fixup

Then bisect will be broken.

If one is testing just this patch, DIO read repair will trigger the=20
ASSERT().

Is it possible to discard this patch and completely rely on the last=20
patch to remove btrfs_io_needs_validation()?

Thanks,
Qu

>=20
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2616,6 +2616,7 @@ static bool btrfs_io_needs_validation(struct inode =
*inode, struct bio *bio)
>           * We're ensured we won't get cloned bio in end_bio_extent_readp=
age(),
>           * thus we can get the length from the bvecs.
>           */
> +       ASSERT(!bio_flagged(bio, BIO_CLONED));
>          bio_for_each_bvec_all(bvec, bio, i) {
>                  len +=3D bvec->bv_len;
>                  if (len > blocksize)
> ---
>=20

