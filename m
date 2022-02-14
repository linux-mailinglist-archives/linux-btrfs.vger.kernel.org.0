Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30624B4F13
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352526AbiBNLov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 06:44:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353153AbiBNLnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 06:43:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033762D4
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644838570; x=1676374570;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=inqD3eaMjcLBlV7CqX07FvFC4YLv8oNlbm7SEw7l6YA=;
  b=WWumtwkiEz1IQmi2KwjW+kK4fRowjtZuCFNNrt43BynforgYb9CzfdW4
   q0SrYV0dSqMgPFpUNsxZplhwsK0LshzH8W+N4E7SAfkkz7lqCDm4N1bfd
   g31b7REobFCxqZVzRlEr9FntsGlH8FJS9iYygjGafHdw4R13qBmiMvQbA
   8pm7Ux4UdPIfaSyxeVrQBOjc14MeTqo8LPO1byXTUJV7kjDyIPYyPWqH+
   2l8ysizAOea2UZ5Cn1fbwebDHYJ8416JDj/uOOiQnO+a04mH7s2G0m6P5
   HjKKfZdh+moOt1Ehjxi0d3qqf3PO6llXC1G+WF+zSBSNjgXSZm75O7R+M
   A==;
X-IronPort-AV: E=Sophos;i="5.88,367,1635177600"; 
   d="scan'208";a="296963129"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 19:36:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iin90UiuclSmewsdcdJoO7MabEnJUKwnVyBkquSX3WgiEWADIP/gOlMwNEHFHCdY29TO1BauS6IhTjFbeDO14i6G0EgPBFxlG/b30P/J8eFi5FKB79Hg1Tc9fOcwYRKdbMrMYjoftWVk9KEEUGQbY6YNbL9ULNb6HJDSEMPZVD5by2G1K3jFy6jbcIWnhNX40ztprAV+O7WrNLDGNYDMi8xJqivXjUgz8P1w9VAMj5wGo7BN8VehOfjALn7bCFWndOIt3vgk5WfhOj8Lcjamx8fv3sj1eBbC70tqbC2+KS68c7scDzDGinWXNJHluezs+OWh3p/FEIvZhfAV/9xGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWNKLOKyfjpipZib4kVAHTuUpI6eesD4+3aaQlPiGzI=;
 b=fQvsOG9dmoVUg7WPA91KK0Hb8uZYa4AeipuvICLsw1jP81GzHhYhT0EvdCK6XAiLKAdgXtt2sHKCCdsR4zPEc8ImFtDGoNuHYpe80b07TTFRND1OmNAwvrMKfy3uxKnMPMKlaLuOK2BH0gYX8Pv5nudNwAAV1ONzv3FZwGzdbNkx73aePaeQPgtnz/5lDqpDrfI8ZVLi+S//ZJUkg30+/HKLlCjCKdcfXPWNYQ4moW5pV5dpvIHsYSDRs3fcuNr5HVWubrhnBTKwvUt9dXRokRBln+PKii7yH7O9gGnjQDPlw945l9GHEaNS8UOPSGGjRk6fVWjh7u66VqwTnqwNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWNKLOKyfjpipZib4kVAHTuUpI6eesD4+3aaQlPiGzI=;
 b=I68XHnjmZ4yBqNRtl1eBuQlKyDKGu2OjqE2WiHdsN28zYPwuvT+YBSn9jFOoxpu7uKamlxEnxUpGxqD9mQUIqZrK8r94hO5ZZPtTsEIU7menEaHV3bEre2MSvJon3S+bRqr1aR45bMys1O2fjI+WRcN+/s+ORrp7fgNCNX10hmU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0327.namprd04.prod.outlook.com (2603:10b6:903:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 11:36:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 11:36:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYH07bb/nuUiAmMU+Xod0at5xKkg==
Date:   Mon, 14 Feb 2022 11:36:07 +0000
Message-ID: <PH0PR04MB74161E8AE63F4B9E995352069B339@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
 <20220214113442.zxwpjdcwxkgtlx5v@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95505cb-2675-467c-5436-08d9efae30f1
x-ms-traffictypediagnostic: CY4PR04MB0327:EE_
x-microsoft-antispam-prvs: <CY4PR04MB0327990237116D03A4ED4CB39B339@CY4PR04MB0327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfgL+2fS2wexdnuhDorN00IcXBKjsITgS3Cu3yUVA/aNNaYQnh10h/AvEwU6Yj+bNcZeZBd/uyfUpwwR14q34K333Ta9Qr6WmUKcdRvPWXqxmVQxBPtaR5ZKLkYmeBSQwiNAM8p1rNiFVtibjnd7dTWb0NccInK+tZ2n5yj/I3UtkJK37Pvl+RxBwS3xojze5c5v70fEG4MSeLYsyTU+Ee6AqtkZajFG4/AbfyJxQcwD2GvicdmJkpIJouKmG7mitR76gwT1sEYwXptICGzPYU8q+VvfHEbntE78hgrkTyGvq19RJGpLWj/KlF5vIU2+aUmsDqTYIXmLrmRKL0zNweWyFE+7Op+p/xKVIUFfBEKMKZsJfTX/oloc7tJ9FiJYdaPEfFhtrdx+nCH7cYMG/qv4R68Sg4n+yFMww+Mzwm4g8GMbiJpZBDm5CxoCmqRcOQkulqGZipDxRrQcEKK2NWt5k6CEJg6RdemzesWf65lTx+gX6lLR6pfayxzXyLXtf+yCBzlCBAb3H4QZjOFdV4XnVsag4Y7LDeChygeBHSi0Nd+rIopzASb+IMoI6ercZJZrS1/wgDpdjixkQw05y9/JgWnBcAod04DXR/AVd0nBmkMYLnVEHb50Aln0xIBtNACFYYzCPXvPcOfY8E4Hr5+/xnjcIsTuTduTdtVwpLGQFtcfJRmPsXq0FzDQJSpINNLummsuQgCBakdo1/alrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(4326008)(316002)(71200400001)(6506007)(7696005)(38070700005)(9686003)(53546011)(186003)(508600001)(66556008)(66476007)(66446008)(64756008)(66946007)(83380400001)(55016003)(76116006)(6862004)(8676002)(91956017)(6636002)(52536014)(5660300002)(8936002)(86362001)(2906002)(38100700002)(33656002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCoBPOVWkC5oy7ojnIIlxCrtraU/Snr65nFIMExfI74QMSoHMvsDttUtrZ04?=
 =?us-ascii?Q?lO47s8PJaNsnXooYlXZpcVl2TVDIN927HIQJc93+Pa2xOk92hBcZ7hkV34RD?=
 =?us-ascii?Q?Y7vrdnQXS4c2tJOuYUGMbnFTlhzKEDR3y032Zf4sNOOudZ9sALk6mRoG4RYT?=
 =?us-ascii?Q?+ugo8h3powrPdqW0vzFdcgO18uZXbVRjUWrxmPCoDk/HNV9+7mddiyWdeJpA?=
 =?us-ascii?Q?FBkRfeMir5SC5fng1GB7ZgdBJizPP5J3gLQRjbJ+EzVlbA26KB+rES0XRRkp?=
 =?us-ascii?Q?ZQKsD0DnGhkwF6284FMvK3NLRJLKpEeSlqP2M0sZSo3NTYrb4VtIHTaUGpa2?=
 =?us-ascii?Q?SxT+j6yWIKRQfnQIF/szpTfEm10g9cHL43QoIoKxEalClkPL7We+qMBE6gnT?=
 =?us-ascii?Q?EC8kHciFhpX/itvRS4VYsdfGj5Kct12c269oOco9EBFLH+zKKgLy2LtuaW9K?=
 =?us-ascii?Q?rHsZma/UxJT1USoMZo5N36NHka4UnlvOwn8yBZSZt+P+CrzyJUJSNLG6HXbp?=
 =?us-ascii?Q?PgT7+CZFdPtGmhuvbaR4b5LFV1tBg9IiUaMN4OZ5O/ztBoxUoO8UGciXn0VA?=
 =?us-ascii?Q?i5BAd4UlGwNegSInBoo3QL7qZvof8FohXMkeJxrMNtGh5qXDAx8lDBxxi8Rq?=
 =?us-ascii?Q?4e/0YnuRlK1ufu0yfdrKkETfraQ4l8vr03/jEiszYW4QQ3CftEy/B92WJ/o1?=
 =?us-ascii?Q?Iz39OcyEankVG6M1LreeyhulxIUsAEXwCQb0h2RbRQhRR8aM1A8dXJ7GfuO/?=
 =?us-ascii?Q?hNNXlSeVuntTgy62j99vwJ4mIbOTcIsjoQEfbsHYLrM2LSQXYkgmOkvc5i+a?=
 =?us-ascii?Q?EUyDA7fqoMWub9IlENHYoX4lzFPguReO8l2mvTd7PiUvD9HjY7gTXci3QAZb?=
 =?us-ascii?Q?YEMGzRFLZJzr0nR2CkjaZMDHqXBA24j8U1qXCt3GiYB/ogVzv1UfCOXzpcZS?=
 =?us-ascii?Q?2nz4qqivzs2nBSj7BEQR0dxnutTNRFPQYTL1pteX10cQIVXmg8X5QbDeCxA8?=
 =?us-ascii?Q?Gu5w0NxEUqOSaXYCmzby0W4GF9O4xQo1vULF9QKob35PuOjp/95QnfnFw624?=
 =?us-ascii?Q?7mjwBnP/fSJFC4Wl1iG50GGAAkNy4svaG2uPfa1efJc9pVD32af0AZj2ngom?=
 =?us-ascii?Q?Qk3YKx2YPoiMGUkbUHGrdAGaGqV/aMeSAXeVnqKCtyqOW3HOJ53ozFeq6jq6?=
 =?us-ascii?Q?Hfqv5R4EgQ3I6by7vV14yWFVQ3nL9wB9YxRCUxmF0RajMjCvTSqoZY3m6kRl?=
 =?us-ascii?Q?M5cdkIjx/KqHkydepcgeyt2axltGamURKci93tzn9PUUljt6MPOzXtOemNOl?=
 =?us-ascii?Q?iWWiylQA6uCLFw9Ouw35EgAhJ9X4NOarCVJQ8/zPWDQ6zFXrAsiJhf6uOhYH?=
 =?us-ascii?Q?KAJ3thDTYgoqKon7SVe4Zv8HId6075I1gxznu99Ox5RJqztdWoa9lL3ibWxN?=
 =?us-ascii?Q?MeC5Zb2JGOgaDZhgo3XJ5eRaiEHr7CEZ6iFmfOkk6NFTOfNF7qvwGqz5rz2U?=
 =?us-ascii?Q?zpBQwnLdiYItABuyWm6nLimirrtZgAtJJiCJ6tCQy2iUl+W1ilqs//vpGGUg?=
 =?us-ascii?Q?ngDXdjyx37E2FebMoHHfVGzAbyaHJx7sPW4Ysx3nsX2BGOo0y3xNGiOy2jdG?=
 =?us-ascii?Q?0TPjvvxiT9Ff1paVgWY6LAKmgxEyjHadczDH8WOKiqS6M968qPLZUcmxq9pk?=
 =?us-ascii?Q?m/myjZKA+foKWOdXp7JO0QjLGSCLNgxL//7BjdYze0ksvVLfp6KRYUY3Kl0p?=
 =?us-ascii?Q?z7OOLxz3GDc5dJWrPn5MgvOGgXAsvzo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95505cb-2675-467c-5436-08d9efae30f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 11:36:07.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm6xSXQGkOlqnF57zdRhrHg1+mbz6q3Q43cWabcEz7c2coS1V29G2JlQ7l+dNAMa4rbmAv/t9CrW3zpqcIQZ2CoWIuvXDRhC5BKHhkFrPb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0327
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/02/2022 12:34, Naohiro Aota wrote:=0A=
> On Fri, Feb 11, 2022 at 05:54:02AM -0800, Johannes Thumshirn wrote:=0A=
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
>>=0A=
>> RFC because I'm a bit unsure about the user interface. Should we use the=
=0A=
>> same value / sysfs file for both the number of non-empty zones and the=
=0A=
>> number of zone_unusable bytes per block_group or add another knob to fin=
e=0A=
>> tune?=0A=
>>=0A=
>>  fs/btrfs/block-group.c |  3 +++=0A=
>>  fs/btrfs/zoned.c       | 29 +++++++++++++++++++++++++++++=0A=
>>  fs/btrfs/zoned.h       |  6 ++++++=0A=
>>  3 files changed, 38 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index 3113f6d7f335..c0f38f486deb 100644=0A=
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
>>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>>  		return;=0A=
>>  =0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index b7b5fac1c779..47204f38f02e 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -15,6 +15,7 @@=0A=
>>  #include "transaction.h"=0A=
>>  #include "dev-replace.h"=0A=
>>  #include "space-info.h"=0A=
>> +#include "misc.h"=0A=
>>  =0A=
>>  /* Maximum number of zones to report per blkdev_report_zones() call */=
=0A=
>>  #define BTRFS_REPORT_NR_ZONES   4096=0A=
>> @@ -2082,3 +2083,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *=
fs_info)=0A=
>>  	}=0A=
>>  	mutex_unlock(&fs_devices->device_list_mutex);=0A=
>>  }=0A=
>> +=0A=
>> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)=0A=
>> +{=0A=
>> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;=0A=
>> +	struct btrfs_device *device;=0A=
>> +	u64 nr_free =3D 0;=0A=
>> +	u64 nr_zones =3D 0;=0A=
>> +	u64 factor;=0A=
>> +=0A=
>> +	if (!btrfs_is_zoned(fs_info))=0A=
>> +		return false;=0A=
>> +=0A=
>> +	if (!fs_info->bg_reclaim_threshold)=0A=
>> +		return false;=0A=
>> +=0A=
>> +	mutex_lock(&fs_devices->device_list_mutex);=0A=
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
>> +		struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
>> +=0A=
> =0A=
> We should check "if (!device->bdev)" as we can have a missing device.=0A=
> =0A=
>> +		nr_zones +=3D zone_info->nr_zones;=0A=
>> +		nr_free +=3D bitmap_weight(zone_info->empty_zones,=0A=
>> +					 zone_info->nr_zones);=0A=
> =0A=
> Here, we can use device->bytes_used / device->disk_total_bytes instead=0A=
> to see how much bytes are allocated as device extents. This metric is=0A=
> also usable for regular btrfs.=0A=
> =0A=
>> +	}=0A=
>> +	mutex_unlock(&fs_devices->device_list_mutex);=0A=
>> +=0A=
>> +	factor =3D div_factor_fine(nr_free, nr_zones);=0A=
>> +	return factor >=3D fs_info->bg_reclaim_threshold;=0A=
=0A=
... and we should check that 'factor' is less or equal not more than=0A=
fs_info->bg_reclaim_threshold *sigh*=0A=
=0A=
>=0A=
