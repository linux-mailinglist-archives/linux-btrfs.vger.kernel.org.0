Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196D3A25BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFJHrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 03:47:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28873 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFJHrv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 03:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623311156; x=1654847156;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vVoTy+avwcXRRBoUtV7dLh9jdISfM8dPQDJoviQTP3k=;
  b=jygBgc7eHKlixDM1JVAzoqNC+h9pv3HiuBSJAR4o/3zohc5w0651xF+K
   W/tnmMo5pgNH3AJ/95jAQI5HCR8nTI0oQsd1XK4x8DLAJoI0jRKVdibUK
   s175ThnsJA+ermSmRqiwGIwfssyFAkBQJxes9T8Hb379GO+x6+QNMKncd
   k4sxp27/LcEhhzop3BSasFAvYH8QB9GhIMqpgHZR0Ts9EFgvoyB18D7zs
   Z7TwR3Q/DxdLraILdMl+ulrpgFBF6qn5C+qYEdvVUPz7wQgmUwIBQUGlw
   2Xmfb0YZHBV5snIGNlStL1RUWKtHTkgumvJVgS1rwxD6cPaexXpm9s53U
   g==;
IronPort-SDR: tk/IXHgQ1ukipa+2EQpsu5+mnQ996wRMSynid1nnkouuJyGmBkmSqvv2F6qsaPVOgXzWvvfqho
 DxR0kDrjEC4EonMSukxzbvRQuK52bGWut2JZ4XQ13riMOHPR1s+7SfE8isei+5rqKUqUHYQkb7
 HJD4X8Nds0sJhWba4RO1NWT2KLK+T0igTRfc6mO5L521Zzm4/MCuKljDymZ5n/4IZ3fICiRGQT
 vPjyOo0cz8pno3GYt/cbmOFMZx4bigQGRVMdmhGTLBzyURQ5Ty5qskqv0OI24g869KPiIy92rP
 H30=
X-IronPort-AV: E=Sophos;i="5.83,263,1616428800"; 
   d="scan'208";a="282859268"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 15:45:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4cv8zA1SojtTzgtibu94m2z2VeFtfhjtnA0uIQEMFAIVy/Y4UBfYfM6nov3A8ppFX4P8WBbTQMu2FNgUZf7L0jgOiPAQ80TDBO/z3KA3X1GCxJDqQcLCnnt8OmBJZkpkXe3lIrEUhssaKrVNJIOU+KOkjRRxMq4bUTRqQ15CH0gCuFyMox3p2BTJuTWPxYxpNW+yVg1k5usEShsF7KPtDIgixVnomPSDCmGeKAxR0keiHud+kFz9lpqyw7X69ZaBgA+s1UGVKhWzdKAYgxXPxxh4E19gesRJVNcl8WoWN/LPXrCWOUbu0CTqOZ1kT6R2/uz8DULTio1dwyu6kYi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbdinn5CDjixQD631QqLuMMSuiQfA+BezlspruDQDZQ=;
 b=hfEPlI/0KS7swI748/iOsacJx5aV+GPu1UGqTAn6++xyCjnruUIq1vfWio5sjblpJd9XhOhSWxH5zQN+O77s+MV+8e9GMRJE129w+bd64t1TFfr6pdJF7XWCQRaAVsrUVmdgZR6LYMEQ5VdiHlSdjP+lbzRDLfjVmcxg/hC1yaKrBwJnzqJj+Vqmda4seN7spEObip78UymFQUpB3Tuu4OZQnw/hl1aBHgNN9joWYJeZ9nPNaU0qzHZ7pVYonEth44hldhPkXx64yl6IApJ2cGR/mZIOKE8EWO93sGypkk/Ibpr+JbQKsJHh9TVY/4yxK9rEZcC2jeYLcb13l9HlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbdinn5CDjixQD631QqLuMMSuiQfA+BezlspruDQDZQ=;
 b=qHPaBraRFwWLLnO7UiiE+zG8Zq/mHOIrcVEhzgICF/02SF6MzwoXr4tdahR8s7MHNDZbM+iJYxhdOB0xlQIBAaDR57x4GLLE4jz6xXPz03c1UOf83jd5mHrWEGwKgz5Mx/pkuCbH7U4RvHWcbsLh2bJY186DskVtapHckv00yew=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB3754.namprd04.prod.outlook.com (2603:10b6:3:fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Thu, 10 Jun 2021 07:45:52 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:45:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Index: AQHXS/w7IU+fudj4aUGr535tkQGBcg==
Date:   Thu, 10 Jun 2021 07:45:52 +0000
Message-ID: <DM6PR04MB7081051CDED378C54A364E68E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
 <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
 <2ceddf4f-f2b9-fe7c-0201-46835cc27c45@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa640ad2-b688-44c6-3e51-08d92be3c5f3
x-ms-traffictypediagnostic: DM5PR04MB3754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB3754FEAB65607761D4816B7FE7359@DM5PR04MB3754.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IePc+OQesKy2+lElkMwtIT2cm3R5V3Z7mVomlP8t0uVoPb4sEL3/VRrIZJIyMnWRT/r5kLua6GAbMIc8b/1ek0rgVmi8O3Lbi18i6nBxP2VG7HB+lNpmYUsTiRwjipYikpjliwrS45DUfqkPOwRRB0I++8TRCMDAOZREvkoLuYSyi8dtsutXxavWpOINN+/28nw8pPj98GxUpVqjgzLtWJKOQp755sD5uQ9vyAIOZhT2hd0jHr+f0aYubgz/b5JKnZxcoB46GIhdhWn1SW4utSnHYfwWRccuVBE4QYGO32L+EZyMZnw9VJHwYEMJqcwKFv44SqdKgpB2sB1fdvHgZnqVFVJxZCrYzkwu4yiKuqSLQ1nc7kkSxhDShd1bcTx8xroqnpd3ziHm2vNd8pd8HS5tJT4xH+4As4WveFVSAvugGrqfpUn6MaBSlMsaR5ISE/7xP3zqUXIxvKOkMcGiEXnHsUnzNBEjXMd5fp/2SvRO5jI1wRDMJzIAeG0j63wJ/m+loPdRhkShcaNpGXPuWQ5rvpFWIP/gcBGg5246mUcku5L6aclorXdXTP1M54xXl8YyMMq/Cq/Dt9JxlhTWOYcOIwJRbkg8gNDee/UqWP0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(38100700002)(122000001)(8676002)(478600001)(5660300002)(110136005)(26005)(91956017)(7696005)(76116006)(186003)(86362001)(66476007)(33656002)(66446008)(66946007)(66556008)(64756008)(316002)(8936002)(2906002)(52536014)(53546011)(71200400001)(6506007)(83380400001)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K0kzK2VqZmUyTU9BY0JvRS9td3NlZ3FkNkdNL25na091bnVMWndGSzJq?=
 =?iso-2022-jp?B?bGtWeW1nTjF1Ly81TVFtSGp1ODE0L3hDZlF3VnFEQWZQVy91bVVXRzVF?=
 =?iso-2022-jp?B?YWJMQTFvWEpLNEdQYTFMTDA3ektaTnBoTEdUUy96YjNORk9UOURpd2lq?=
 =?iso-2022-jp?B?R3BTYVFtSWgrYThUaWhlRWN2S0JrcnZ5U0NoT2JwWVRHd3FQVjQyd0pv?=
 =?iso-2022-jp?B?eWdOcEdkQUFtQXJGU1BFZkkzRnU2RmtUSTZiei8zNUxjai9yVHZzMG9L?=
 =?iso-2022-jp?B?eFVaa3hsVDUyZ0tnWWJaSk8zWVhUSDMxNVUxdFJuTWN4dEQ5RkZiODJK?=
 =?iso-2022-jp?B?eWpLSXJhWWRQYkN0ZXd0d2p2SjBTYzkvdVRPdUNoSnVnSVFXb0lObUdH?=
 =?iso-2022-jp?B?TTd5cEN1TDZqb0FJVWZPdUs5UGxoYUVNaFl2S3licjlEU3ZsbU1sTFJU?=
 =?iso-2022-jp?B?QTNBV082RXlyWWlzQjZBd2FUSm4vZDJGbUprMVFLdDdRbFgwUnBJRXJO?=
 =?iso-2022-jp?B?Y21uczZLVmNSVjNoT3NJMytNQXlFcXFrTUxzaG5aUlg5bEFHU1UzQndJ?=
 =?iso-2022-jp?B?YkE2aWxxNFJmNEJSMXNjczJ3R3RmbXJTU3hDY3QwZGZJRkJQRElJdVVv?=
 =?iso-2022-jp?B?MVVQSm5SOVliRmNzZXQ2RGhpdnpudnlES2xuTURsUUtuNG4vQzZudE9M?=
 =?iso-2022-jp?B?WHRwdWZuaG9KVURXYTJDcUkyNURvaGE5RlFMY2tPYzk1RjJWZXhQOEJB?=
 =?iso-2022-jp?B?dHRwSzB2QWFhNGZ0ZllIdE5mdUEyL1BQVjhwZ1lYdFR3TlJoMXB0SEZD?=
 =?iso-2022-jp?B?UUpPb0taOUJ3TFhtL0tPcnJhMkdQc1U3dTVxT2R2b094SGg0RjQ1cExx?=
 =?iso-2022-jp?B?a3lwajVQS0p4K09XTnR5SU9OYkg4RU1LUW5mTGQxajh4RUJwOWNuN21s?=
 =?iso-2022-jp?B?WHd5ZnBnMUI5OEpUQUF1UFlWSGlJUGE3eFpSTDhlYXJzeGdqRmpNMStq?=
 =?iso-2022-jp?B?U2UzblpUZUdqTXVrMEU1ZUg5Vk5jemx1M0xtQUg4Uyt2QXYrZjMrSnh3?=
 =?iso-2022-jp?B?Z2NuNFpHN2pEVk9HYUR5eGF1Q3FTczVDWW5Na2pDNmNwelVvRjk4N2Fq?=
 =?iso-2022-jp?B?SzZRYTR3ZStpdTcrK091YXpPaUZ6ZDZpbzhGWUJ2TXNPVTdVUFFIdEtG?=
 =?iso-2022-jp?B?ZUtSMkt2NFI0aGxtK05HeUFXTWM4K0ZtR1RtaWtZSWVyTzJzTlI1ekNZ?=
 =?iso-2022-jp?B?UzRaWk8zOTVtN3BRS2JMeVgwajhrMXlWMmRVWGRIM0VGd0VvU3F4N29w?=
 =?iso-2022-jp?B?b3JubHBVYTF6ZGphWFNLT0dYSnZEclZLQ0ViVERmbkh0TlMrUzB6OUwr?=
 =?iso-2022-jp?B?MzlrK0tkV0FPL1MrMnArMEpXSDdWRHdpQUI3QTNQZG5LNCtKU0hTNHpN?=
 =?iso-2022-jp?B?Qm02MzFJbHh5cEpKelFNUFR0dGwwVk1tMXFLU00vbXFzb2hSbm93UmFp?=
 =?iso-2022-jp?B?bTVFcTNNQWM3cUR5OWJiYXFBYUZlbWVWM21mQXdqdUJ5M1VIVVg4c1pl?=
 =?iso-2022-jp?B?NE85a3ZLMllnL0Zld1RHVWpubjhoSlBkbmYrWTREYUNwdlRIdkkyVit3?=
 =?iso-2022-jp?B?cFdzSGwwTnZsenEzZUVKVUQ2VDMxdVR5WFRtb3hjNFJlUWowYVh0QWZH?=
 =?iso-2022-jp?B?VVVFVjRNNm9xWTN6SURjSENzeDh1dDVQRk44RitzWUFmZTJtSXJrelgr?=
 =?iso-2022-jp?B?S2ZZRXVpNnV5clRiYWlYQThwZ3V2ak04dkNDaVFja0lnL2JXbEZmSGJH?=
 =?iso-2022-jp?B?YVJsamU1N2k0ZFpUajlSSWtjZER6d2lnYjkrNzZucWFRbFNwNlRpT3Yr?=
 =?iso-2022-jp?B?UlhvT0dLS2Fob3dQRDA5bm5zbk8ySDllVjVLYzdPMzIwbEtoV0cwcEVG?=
 =?iso-2022-jp?B?Y2pxTi8wZzJzZWJwK3RNaDlqSlVqZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa640ad2-b688-44c6-3e51-08d92be3c5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:45:52.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SfoZUgtNWeOFSpkr74siXRAX4FhmnnCweZFab8Fv/VYM4q+DRsPVRvwwd0ZIsMr+/x5vaCGEjoFR6i2ndazHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3754
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/10 16:41, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/6/10 =1B$B2<8a=1B(B3:36, Damien Le Moal wrote:=0A=
>> On 2021/06/10 16:28, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 2021/5/18 =1B$B2<8a=1B(B11:40, Johannes Thumshirn wrote:=0A=
>>>> When multiple processes write data to the same block group on a compre=
ssed=0A=
>>>> zoned filesystem, the underlying device could report I/O errors and da=
ta=0A=
>>>> corruption is possible.=0A=
>>>>=0A=
>>>> This happens because on a zoned file system, compressed data writes wh=
ere=0A=
>>>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND=
=0A=
>>>> operation. But with REQ_OP_WRITE and parallel submission it cannot be=
=0A=
>>>> guaranteed that the data is always submitted aligned to the underlying=
=0A=
>>>> zone's write pointer.=0A=
>>>>=0A=
>>>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zo=
ned=0A=
>>>> filesystem is non intrusive on a regular file system or when submittin=
g to=0A=
>>>> a conventional zone on a zoned filesystem, as it is guarded by=0A=
>>>> btrfs_use_zone_append.=0A=
>>>>=0A=
>>>> Reported-by: David Sterba <dsterba@suse.com>=0A=
>>>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat fla=
g")=0A=
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> Now working on compression support for subpage, just noticed some=0A=
>>> strange code behavior, I'm not sure if it's designed or just a typo.=0A=
>>>=0A=
>>> So please correct me if possible.=0A=
>>>=0A=
>>> [...]=0A=
>>>>=0A=
>>>>    	bio =3D btrfs_bio_alloc(first_byte);=0A=
>>>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>>>> +	bio->bi_opf =3D bio_op | write_flags;=0A=
>>>>    	bio->bi_private =3D cb;=0A=
>>>>    	bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>>>=0A=
>>>> +	if (use_append) {=0A=
>>>> +		struct extent_map *em;=0A=
>>>> +		struct map_lookup *map;=0A=
>>>> +		struct block_device *bdev;=0A=
>>>> +=0A=
>>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
>>>> +		if (IS_ERR(em)) {=0A=
>>>> +			kfree(cb);=0A=
>>>> +			bio_put(bio);=0A=
>>>> +			return BLK_STS_NOTSUPP;=0A=
>>>> +		}=0A=
>>>> +=0A=
>>>> +		map =3D em->map_lookup;=0A=
>>>> +		/* We only support single profile for now */=0A=
>>>> +		ASSERT(map->num_stripes =3D=3D 1);=0A=
>>>> +		bdev =3D map->stripes[0].dev->bdev;=0A=
>>=0A=
>> This variable seems rather useless...=0A=
> =0A=
> No need to bother that, that has already been removed by later refactor.=
=0A=
> =0A=
>>=0A=
>>>> +=0A=
>>>> +		bio_set_dev(bio, bdev);=0A=
>>>> +		free_extent_map(em);=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>=0A=
>>> Here for the newly created bio, we will try to call bio_set_dev() for=
=0A=
>>> it. (although later patch refactor this part a little)=0A=
>>>=0A=
>>> So far so good.=0A=
>>>=0A=
>>>>    	if (blkcg_css) {=0A=
>>>>    		bio->bi_opf |=3D REQ_CGROUP_PUNT;=0A=
>>>>    		kthread_associate_blkcg(blkcg_css);=0A=
>>>> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,=0A=
>>>>    	bytes_left =3D compressed_len;=0A=
>>>>    	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {=0A=
>>>>    		int submit =3D 0;=0A=
>>>> +		int len;=0A=
>>>>=0A=
>>>>    		page =3D compressed_pages[pg_index];=0A=
>>>>    		page->mapping =3D inode->vfs_inode.i_mapping;=0A=
>>>> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struct=
 btrfs_inode *inode, u64 start,=0A=
>>>>    			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,=0A=
>>>>    							  0);=0A=
>>>>=0A=
>>>> +		if (pg_index =3D=3D 0 && use_append)=0A=
>>>> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);=0A=
>>>> +		else=0A=
>>>> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>>>> +=0A=
>>>>    		page->mapping =3D NULL;=0A=
>>>> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <=0A=
>>>> -		    PAGE_SIZE) {=0A=
>>>> +		if (submit || len < PAGE_SIZE) {=0A=
>>>>    			/*=0A=
>>>>    			 * inc the count before we submit the bio so=0A=
>>>>    			 * we know the end IO handler won't happen before=0A=
>>>> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(struc=
t btrfs_inode *inode, u64 start,=0A=
>>>>    			}=0A=
>>>>=0A=
>>>>    			bio =3D btrfs_bio_alloc(first_byte);=0A=
>>>> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>>>> +			bio->bi_opf =3D bio_op | write_flags;=0A=
>>>=0A=
>>> But here, for the newly allocated bio, we didn't call bio_set_dev() at =
all.=0A=
>>>=0A=
>>> Shouldn't all zoned write bio need that bio_set_dev() call?=0A=
>>=0A=
>> Yep, bio->bi_bdev must be set before bio_add_zone_append_page() is calle=
d.=0A=
>> Otherwise, there will be a crash (first line of bio_add_zone_append_page=
() gets=0A=
>> the request queue from bio->bi_bdev). I wonder why we do not see NULL po=
inter=0A=
>> oops here... Johannes ?=0A=
> =0A=
> That's because it's really really rare/hard to have a compressed extent=
=0A=
> just lies at the stripe boundary.=0A=
> =0A=
> For most cases, the data we provide for compression tests is either:=0A=
> - Too compressible=0A=
>    Thus the whole range can be compressed into just one sector, thus=0A=
>    it will never cross stripe boundary.=0A=
> =0A=
> - Not compressible at all=0A=
>    We fall back to regular buffered write, which will do their proper=0A=
>    stripe boundary check correctly.=0A=
> =0A=
> Thus it's really near impossible to hit it in various tests.=0A=
=0A=
But this is a data write, isn't it ? So in the zoned case, it means a zone=
=0A=
append write. And adding a page for even a single sector using=0A=
bio_add_zone_append_page() will oops if the bio bdev is not set, regardless=
 of=0A=
the bio size... Am I misunderstanding something here about this IO path ?=
=0A=
=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
>>=0A=
>>>=0A=
>>> I guess since most compressed extents are pretty small, it's really har=
d=0A=
>>> to hit a case where we need to split the bio due to stripe boundary,=0A=
>>> thus very hard to hit anything wrong.=0A=
>>>=0A=
>>> Anyway, since I'm working on compression code to make compressed write=
=0A=
>>> to follow the same boundary check in extent_io.c, I can definitely=0A=
>>> refactor the bio allocation code to add the zoned needed calls.=0A=
>>>=0A=
>>> Thanks,=0A=
>>> Qu=0A=
>>>=0A=
>>>>    			bio->bi_private =3D cb;=0A=
>>>>    			bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>>>    			if (blkcg_css)=0A=
>>>>    				bio->bi_opf |=3D REQ_CGROUP_PUNT;=0A=
>>>> +			/*=0A=
>>>> +			 * Use bio_add_page() to ensure the bio has at least one=0A=
>>>> +			 * page.=0A=
>>>> +			 */=0A=
>>>>    			bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>>>>    		}=0A=
>>>>    		if (bytes_left < PAGE_SIZE) {=0A=
>>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
