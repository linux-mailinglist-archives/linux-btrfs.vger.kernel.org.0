Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA14D9DCC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 15:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiCOOjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbiCOOhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 10:37:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BFF5548F
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647355003; x=1678891003;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sMnAhXOq+D0IycbAK4pVzA8GgI09K7bxivxrQyQPSsg=;
  b=ZoJP6nqQNTY3DWpNbU6bPXjfK0li10ekt+3U5DwcF99cJIx7Q8fVngcz
   EvDt5cIqlK3Ac2OAPrXmL8nWNLi/ZXFHwMmNy8bVyWbEvU9xa8gaefchp
   L06w1Cwl/Kvy8Ubz4eAHxjzNX5pqkQBkqgjz0H90/k0Q6X595egcDRj5M
   XrZrLyBp1LJ9GHEZ3Eo7Y+/htefwWsmsI6PlscsrLxQFiZUSuRqBQrxov
   hWnldWxP2T4OnLpbIuUqCu6Or5NeZFYKYvD4DUfiJn57qCKCfa2I8ZnUk
   vDGqd8A8EwMHaSH2V8Hp1grrFoSk0cmZmVr32m5or9ek2e+scc/E+xKF5
   w==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="196353385"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 22:36:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk2qyoZDuePOZtGQtW1ywDWAHzL8SwgGTmEwSoxgrpQkX3pdXyhnL06duAd2bKvii+DQem1MePwtv2JlDXjhZE38TPI1PNR17pwCAd2OcilRR7SWGtYeexYsrt4ZyB/AeRCKATxs961jSxjNU5XCNLF3LCknPDZmIQCYpI+diuc7e6XT7fn0yS0PAlrXTMWOaNnqThq1Om8QGniJ8Z1vEbYk9WRsMfJBr8yvpeaEXV4Utwv7ky6uU/TW6+J3AJT7941TmL6tBGkZbHEQLMIkAZ9BvZzAha4Go1zgGf6JNFkNtaTtA3BY2j8M6V/k/nGkg3RGw/WW/LzHGnncTDPu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsBZEgEwZXFmr9UoA67qyj0HJaJa8ES5dvlou5dNLhQ=;
 b=E6j4YhtwZCPrj6zOdfH0yQ3TBKtFpKCdP93NQwhP38xUOAh1w4E5VeCh2wJuDxNUh5waAW739OMrnP1jW7mcn3AnuoP/eE43hNRDHsVz2O18taSoEGcRPGnGNHuTsK8MCIXUbHQGznh885NNmF71k22Dax9UBn3oXsEgf4nEx2VBTOpI7HjMBi8ovU8ov7Q7m9kGsFQ52s6lcr2Q/Iy4gNL1LG7q44uUDTa8Jed+Eb4O/Yg6V0XLBJmKrU2KUjR0QzGLFR2aXrha+PtNpqJSLpuxCLwD1SIihzQH8d+VpcPRLpjqnVLtj7DmMwiAZuibxkMBf6792KZGu0zd7JlLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsBZEgEwZXFmr9UoA67qyj0HJaJa8ES5dvlou5dNLhQ=;
 b=gzwQA8g9fK4GBrxMu9L81l65GSOy4T5KxKqlyvMinGsGNITODB/msQufS4It7LEBou6S0NIxaMWQHjtprwx3B/P7Rj+c5JsWD/d1v1Mscwtcd+KdgIGkZqN+XituMK4D+PK7HIoanPzI5HX6szLmcYBk2k4EQU/f+OpSDgi7ub8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0896.namprd04.prod.outlook.com (2603:10b6:301:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 14:36:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 14:36:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYOFxAQiAIT4o+/k68hu4scsxCjg==
Date:   Tue, 15 Mar 2022 14:36:39 +0000
Message-ID: <PH0PR04MB7416A921B0CC3224FCCEEBB89B109@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
 <YjCgwU3uyz4FA4qL@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdef68ac-523e-43f4-43ba-08da0691379e
x-ms-traffictypediagnostic: MWHPR04MB0896:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0896192AE98C035B2333561A9B109@MWHPR04MB0896.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: If85gYwaEOHiPTeTJ3X4/UGJdpxOHNuUw3ZXkc19YlKc4ci5sA8y18qs8o+HStevxxQQFc3NfzCoZRC/dT5QpX0BDzDvf+dcnkeE15gGr+ACcPjQJ7RzPlz3a/JKljsFzMsoJ05DSonqcrRnM9cNXqJ164/RuKzHW3zHTp+QSeEWDvHTIgFOdsd09cv1Pm4RGni5H8DllmZPavxdMmxul5+QnEOCB7lTl+zpCEtY71ZmWSBkLaIZvLIQTU/IgceUguCxBpeyKcWPhwB19nthU77XYIpT69FkJlhD8dnn2xURSvO0h6mteKuzRhoMfjmmm8CFJt6xVQqYz5EyAcs7rEOrjlQgwfrqk4YdaDnEoyG9YURFGVmJJWped0Y7i8QRMVjgSKjk+8tZuHpFgVEmwEYERxYFzNRdcx2K69v2aPobCsoXQK6+hLRuFJocvshi69auv79Y3DeRt6tylLuBsrSq1eyH4ogVkrOHrbzCqKQ5X91Utus1xeP3Up2tJFLc9snP+Oc9kpzfRMFjYEEA6J/HZqpjOaoEO+FSQ+Lkh58Q2ePQrOvKawWbtN1N3NtqndoSKlGdrKP2PCNtpXRgkHYxb3rIAEJ/Bb9sLHi5R7rOtMEIqdz3l6mZFuD00kAHuAwm3qOaNNNUFeau1QS5PwkLxw7IWUgye8KE1J1xR1N0+T7t72N+b12qYRy8JBfQbCQBHWKA8U0+gnv/aV+x0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(82960400001)(54906003)(186003)(6506007)(9686003)(7696005)(53546011)(38070700005)(6916009)(52536014)(316002)(5660300002)(33656002)(64756008)(66446008)(71200400001)(66476007)(66556008)(66946007)(76116006)(83380400001)(122000001)(86362001)(508600001)(55016003)(91956017)(38100700002)(2906002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ymP1HiPUHWhZs8W7iZENFSRDlwifO0RBpyYU1c+6cwDf3TYP0oQC9OcM/8YP?=
 =?us-ascii?Q?qB55DWDk7abBLVbcShWhHu+h+65bxBwE2mi7VOEmeag3zXonGqEVcqOhoriE?=
 =?us-ascii?Q?oGS7uxlanudzZqubF0Q+RM7GfDCHBMTtSEUw8Tun5cBtToFO5QqbZWbwzhoq?=
 =?us-ascii?Q?B5PHbOICRQLrHLDM1Y8MEP+w+4W3EqFQedWs2Pe7PJZ2rsjYBwWcFo2frOib?=
 =?us-ascii?Q?9E+0Ggse1Fv1VH8571lhuncQVxlJ8bs/5UK3xGDLKEUATwxNSgSscOHH3E0Q?=
 =?us-ascii?Q?f/M/8akDbk1CBtOvgBr79ESJV6e1XNb7q9x3jqmgXFpFvusnPSRnZ13sd6yx?=
 =?us-ascii?Q?wQoxL86e1DUAnO/aUy50bQhG3CnKMOkZ4jIUJVmoOGJBk1MqbCRIexvxUJQI?=
 =?us-ascii?Q?Kz7s+o8Bk1Hu49CuBmPu1/GVBhdrFtYg6lyiFnd9Q6MeBWA1p657UicN7XEx?=
 =?us-ascii?Q?AlvsjHf87K8KK38whH12LCW2nS+1om/LQMjvcMZcKsTrZfGmR4sqxcchR48d?=
 =?us-ascii?Q?qt9SQfT7OHQdBFz5f1cL1Ss6FAOvfSvinXf5p2mlIbbh/zrQ6c3SwEkHJ0z3?=
 =?us-ascii?Q?dtcD2w5frjhDjhTu6xdgr1imDhw//X3W1mzRdABpREMCKF2MGEgtZh/fzQrN?=
 =?us-ascii?Q?TzU/WaoY/6/cIX3EHpu70ztVHHFnc7N+U8NJUUd1PbMHq7qIJYgc8f9Rx1xQ?=
 =?us-ascii?Q?Vx3Sj/w1MTB86Uj81uvA1R4YhiByT1R++lBOsFI/o1/6JqlPZz6Z/oVoo5vl?=
 =?us-ascii?Q?jfNOWoNZQ+4gI0QK9rBA2PH7cd+K1gr0SRag+ZI+CwIttRBmtk4+25jI1Ptl?=
 =?us-ascii?Q?WHeRLU9fMzWGmvPeAEdEammJjshIdwCTxLcvIFpeuSKxYh97PcEAJ828p9GJ?=
 =?us-ascii?Q?fAqB9w3aBrK4vOfjY+7huue5sAa+yqB+EuBg81O/SI/2csbUer/Dbld90QrZ?=
 =?us-ascii?Q?ec/Wvp7nZ88f8LSVuGnJphZ1QhH/GCQ2rKlPKhHT8scWF+IudWktgaj7kXrp?=
 =?us-ascii?Q?ARGFn7uU7PGzSJK7+zcNuLCiwlcrf1r2Il2+coawADpDdQhLWqFzV7Td98RQ?=
 =?us-ascii?Q?cBcC2m2iCdeYASyZiTlgmAK+i59zkekHzKJmmi60vNaipQs0S/8pvtDlESak?=
 =?us-ascii?Q?CminIYF8G9EpEHI9cninVJWlTfChK9h2OQ+a/h65Nv9sGGOKOvkP05McmCaF?=
 =?us-ascii?Q?7wm361iu/ViZlbXnJt5WM++t93wYqb/FVSIMJ+dFunPyskKKAIqMqLjgozjs?=
 =?us-ascii?Q?bP6TeEhb2ePqxDMun+r6Rkog4xEydd28b+eisGXjPlPWa+5hddh7QwT6e6o0?=
 =?us-ascii?Q?j2IjcPvrOUs1H9UU0uprihE7673wWNHQWWte1prkx9sMRcddrpSE3eB+Fz2R?=
 =?us-ascii?Q?ghwD6cmOcX7Chh8s9hIdr4QyTkNKxX5ttageHB0qyRnmKFqdSpfxSZ27+/6V?=
 =?us-ascii?Q?bpcJaNvphHBNNWo9SEVLeHInlAYEbtW/9mXOtVg5HndGDtbIfxGKIawYLoZh?=
 =?us-ascii?Q?KPi28Km3HAMU/Yjqm9JYMgCsqqa+YFgPwIeGV4X93taMTpQR9xfZzha3MShW?=
 =?us-ascii?Q?ZWsB4nzgwHltr0ixFZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdef68ac-523e-43f4-43ba-08da0691379e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:36:39.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+85ckDZqtIPWfrNAbksnU1LFlEijMU38KmtH5ie9t5VM/IQWb6ETxFHR0euCUMAGsfvoN6cvwS2OPTHlJVQC+cn6gloN6OItM/IUpGwP/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0896
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2022 15:20, Josef Bacik wrote:=0A=
> On Tue, Mar 15, 2022 at 04:02:57AM -0700, Johannes Thumshirn wrote:=0A=
>> The current auto-reclaim algorithm starts reclaiming all block-group's=
=0A=
>> with a zone_unusable value above a configured threshold. This is causing=
 a=0A=
>> lot of reclaim IO even if there would be enough free zones on the device=
.=0A=
>>=0A=
>> Instead of only accounting a block-group's zone_unusable value, also tak=
e=0A=
>> the number of empty zones into account.=0A=
>>=0A=
>> Cc: Josef Bacik <josef@toxicpanda.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes since v4:=0A=
>> * Use div_u64()=0A=
>>=0A=
>> Changes since RFC:=0A=
>> * Fix logic error=0A=
>> * Skip unavailable devices=0A=
>> * Use different metric working for non-zoned devices as well=0A=
>> ---=0A=
>>  fs/btrfs/block-group.c |  3 +++=0A=
>>  fs/btrfs/zoned.c       | 30 ++++++++++++++++++++++++++++++=0A=
>>  fs/btrfs/zoned.h       |  6 ++++++=0A=
>>  3 files changed, 39 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index c22d287e020b..2e77b38c538b 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)=0A=
>>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>>  		return;=0A=
>>  =0A=
>> +	if (!btrfs_zoned_should_reclaim(fs_info))=0A=
>> +		return;=0A=
>> +=0A=
> =0A=
> Noooo I just purposefully turned it on for everybody.=0A=
=0A=
Right, I think we need something like=0A=
=0A=
	if (!btrfs_should_reclaim(fs_info))=0A=
		return;=0A=
=0A=
and=0A=
=0A=
static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)=0A=
{=0A=
	if (btrfs_is_zoned(fs_info))=0A=
		return btrfs_zoned_should_reclaim(fs_info);=0A=
	return true; /* or whatever regular btrfs needs here */=0A=
}=0A=
=0A=
=0A=
>> +	mutex_lock(&fs_devices->device_list_mutex);=0A=
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
>> +		if (!device->bdev)=0A=
>> +			continue;=0A=
>> +=0A=
>> +		total_bytes +=3D device->disk_total_bytes;=0A=
>> +		bytes_used +=3D device->bytes_used;=0A=
>> +=0A=
>> +	}=0A=
>> +	mutex_unlock(&fs_devices->device_list_mutex);=0A=
> =0A=
> We can probably export calc_available_free_space() and use that here inst=
ead,=0A=
> I'd rather not be grabbing the device_list_mutex here if we can avoid it.=
=0A=
=0A=
Sure, i'll look into it.=0A=
=0A=
>> +=0A=
>> +	factor =3D div_u64(bytes_used * 100, total_bytes);=0A=
>> +	return factor >=3D fs_info->bg_reclaim_threshold;=0A=
> =0A=
> My patches removed the fs_info->bg_reclaim_threshold btw.  =0A=
=0A=
Yeah, which I replied to you is a bad idea 'cause I need it :D=0A=
