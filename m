Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF64265EE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgIKLho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 07:37:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:33283 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgIKLh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 07:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599824233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPgayD6UK27GfinfnOidJy8h88kZJeDR/uRR0WRzJHg=;
        b=k79h4UYVrGtOpQZdV/Gx4wTf7AiHQM0lf6LGhSqfYx16DnkGOTpd/qb23L0zbKF4ZRQmMd
        lhkFvMosyLXLbigsUoruyEC7K+OzN/F3LZYWXdvhGYe9fSpScJngChLRyuja74FfgFjfqz
        S66EPl6zPnctNMt09zU2kZdXGbU/Pg8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-Gni0wLztNM2qKsX6tcbGRw-1; Fri, 11 Sep 2020 13:37:12 +0200
X-MC-Unique: Gni0wLztNM2qKsX6tcbGRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgsDaFK8ebCvpGit/tDtKMt+9fHvjHbwjvIXLwPPaYHGh50XPaWcfPpKrF8xI6jXPn93tzT6aIwb/64gGxGJ0iycI7K18y0Rdra1s0s0f5/stRHpqJg16K+j3fLJxTL6dZGwJyyhplozhxIc2Z5GvX7lH1zIJbiCoJYgjW/rv8dJLSbFmpvsZw3HbmySPn+PDff7N/L6l/Zq0oCpSNLaBiXyt1XaHcewPkE071EAFTyi+opfsGsJ5/DZwdK50r7G7IcrZdn/T3Ev0x+asnHvZox2/tHgtceDgymx2Ynf6stjVSGjPaP5oeYCg0KiMObs7TY0Xmlse4CA3yh9ok2eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQuDGzM4kg6+1O7ZBlTcp8rDf+ifO8/e8Fbmx3M/0X8=;
 b=fRGR9LqHfFu3FOCdCVn1sF4d4TExUTin1/I+M/UotGkEetFCkP/ihfdOpaWHScryWEddqQxO0FCZQbfWuY6HqnqOJ7QlZVYDc76tTJIfBr8uhnhCMtiwufgUJKucX6jKKerftkbRXa2PCB50KwG6cL9YhTMayOsRIWKSu7D51pyuNeB6Icrdmst6IQ1EcgbbgDYgKIxJL8hhE0dCnf2vwxTdTMH83DBtwMhmRHECzKvgSSneGON067tpqAByENh40jgbCssMBl8qYM3p3w2EJRrnEBYuCzG20ynNCeZ/1pqJAau7JW1ZQNCwA9v+kHzB6n33v1fOPICV40/kDtKUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3843.eurprd04.prod.outlook.com (2603:10a6:208:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 11:37:10 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 11:37:10 +0000
Subject: Re: [PATCH 05/17] btrfs: don't allow tree block to cross page
 boundary for subpage support
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-6-wqu@suse.com>
 <661f0e00-0d74-e6e4-f9cd-e1a8ae648406@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <bbd266f4-c329-c15c-37c6-5ef768ad8e25@suse.com>
Date:   Fri, 11 Sep 2020 19:36:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <661f0e00-0d74-e6e4-f9cd-e1a8ae648406@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:180::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Fri, 11 Sep 2020 11:37:09 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b2f8d2e-1357-4044-f93b-08d856470560
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3843:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3843C9CAFA37BBC9133D2848D6240@AM0PR0402MB3843.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVCLuMyyVcw/QkKDFz1sViq8sqZoREEQ+6kwtED5YQJojxJKvO5H5GGtJfdCfabyoWHA6ToqwcxmcgCsffY4kWwtfe8yxVQ7Sd1r4S0HqfbMpTbA5EWnGEgtL9eH/87JGpgmD7WA2XPLK0bH3b1d21Auvx2gBcUqV3E5KDPD6w0GpJj5gCqoToGUXsh62+8yHtqT6UD+Id1eg3ILK0K+uZsbP3rxMgz90D1s6XyiH13gkCWo4SvlWr5X5at7snnHNCNJFDbn8SXbGrEMjooFsuwIv0sDltEMTKMSryjRjyMqH5GfBuUZyAN+eXTAlWy0KMg2nx5UJeULAq4HmyiIAxI1Tskxuz1dDsuLq59f7WOnDX+ol90Ezbzrp+MO6ublzuMfvOSqqfbSJrJ9LYH76RHWMk+Ti/05zXq6hefLDCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(6486002)(2906002)(8936002)(26005)(186003)(66556008)(16526019)(66476007)(31696002)(66946007)(31686004)(6666004)(478600001)(86362001)(316002)(8676002)(36756003)(16576012)(52116002)(83380400001)(956004)(6706004)(5660300002)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5EgjoYxhHVOjbgJBZANSXXa8zpxM09bJW5dvuiDtUT0j2ABKANZMp1gVuhh1log6cRww86dkR01q5564vpTdB8EpUunptUXw2oCf0dW4EQuoKkOixXfxLIrSoAJt4NYpXQSKQB8bZ1r8Iaq8sjp0jj/4CcmwyqLp0XQKsBeADPLc8pTLkhLr79Q7P0uZLBynHce2DNPv7HMgtyNL74jmqYiPGGb5YNzOmOt18KPnAHv9yw37qcq79I6MBmch+U6t8dxgHO9i/afmpiOodkLPyDOwsON245RFi6fj58o8fdnYlKOiPwco2QquqPg7eNOBYDc963amuCYW05ngMRuXTfmwoDeOF7D0IAMsqwwiYFGjwsr3fsoEiXOugMJqPqiR6EqL41yApG7GYtZ4hpHHPy9ZlX0QepkI1y3hE0BuhuJxCDyibqofuXVFaRFVTjOnhqmLlp8kGYODQy36V/a2t15llJQHPPGIAOHBHCq6e21nbrKzUQC8jhnhER2ydNM4zLBKSbUTW+cuhzGUWf31U0uKGo6z6UMY+xZjgtEhSLIe9rSRNKPwQZ9Owp1SMS+FdT3W75NUNFcRWw7UvwH/dgruBduOjQm4Fx+aNI2msRR6g3eYlJDB7EGHiMiindVHmDHu22oiTiY9RsRYY6U49g==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2f8d2e-1357-4044-f93b-08d856470560
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 11:37:10.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zDE0Mmig88WS2SeLJl9m7rAlJVSn+o76uad57Ll6xSRENhPHmHCADXgFUvnM8M5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3843
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/11 =E4=B8=8B=E5=8D=886:26, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> As a preparation for subpage sector size support (allow sector size
>> smaller than page size to be mounted), if the sector size is smaller
>=20
> nit: (allowing filesystem with sector size smaller than page size to be
> mounted)
>=20
>> than page size, we don't allow tree block to be read if it cross page
>> boundary (normally 64K).
>=20
> Why normally 64k ?

Because there are only two major arches supporting non-4k page size,
ppc64 which uses 64K page size, and arm which can support 4K, 16K and
64K page size.

Currently our plan is only to support 64K page size and 4K page size.

Furthermore, that 64K magic number matches with 64K stripe length of
btrfs, thus we choose 64K as the boundary.

> I suspect you assume readers are familiar with the
> motivation for this work which they don't necessarily need to be. Please
> make your sentences explicit. Correct me if I'm wrong but you are
> ensuring that an eb doesn't cross the largest possible sectorsize?

That's correct, and by incident, it's also the stripe length of btrfs
RAID, and scrub stripe length too.

(And scrub can't handle such tree block either)

Thanks,
Qu

>>
>> This ensures that, tree blocks are always contained in one page for 64K
>> system, which can greatly simplify the handling.
>=20
> "For system with 64k page size" the term "64k system" is ambiguous, heed
> this when rewording other patches as well since I've seen this used in
> multiple places.
>=20
>=20
>> Or we need to do complex multi-page handling for tree blocks.
>>
>> Currently the only way to create such tree blocks crossing 64K boundary
>> is by btrfs-convert, which will get fixed soon and doesn't get
>> wide-spread usage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 5d969340275e..119193166cec 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5232,6 +5232,13 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>>  		btrfs_err(fs_info, "bad tree block start %llu", start);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> +	if (fs_info->sectorsize < PAGE_SIZE && round_down(start, PAGE_SIZE) !=
=3D
>> +	    round_down(start + len - 1, PAGE_SIZE)) {
>> +		btrfs_err(fs_info,
>> +		"tree block crosses page boundary, start %llu nodesize %lu",
>> +			  start, len);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> =20
>>  	eb =3D find_extent_buffer(fs_info, start);
>>  	if (eb)
>>
>=20

