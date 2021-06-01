Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C29396E0C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhFAHqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 03:46:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49392 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 03:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622533471; x=1654069471;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G1hd1zJ5XruTE1JTa1uY8OkqMOYvm67r5kI5ubnepho=;
  b=VUzD9k5SHSKHroYY06DKU+PVvJPCSl1udT+TwheuIOixpaASEF5+bPSU
   UliDGir4+Uzt8eMGQekgOjtCkC5CL9lNolEbc9GpEEsXB6pn/CPuL1xS3
   TJyq5mvbF85EkVBOTM5BRYWf84e6aekoaqEXk8Y0q+7alK7bwq45qaC6X
   svG8IvPsvpKPjq1Dj7yvHYldwLov2fBWzHJDq1St8nAiRkflUB2iR4A5Z
   BlQLmvP0q1GC6wecG4joauUij/I4xA5ewFCDYHsSj5HFxmwbFJ3zOgDXS
   z2u6iX4EJb79TVG6qodCmJ977+chfzcVqM/B0VAl4P0XnT7cM3+v+ylbr
   g==;
IronPort-SDR: YTHZyR8PhJeREMu2dXAQ4u/Bix8YQjzQV9Pof+gm0BNMjKirj8sgs0dFRqMy3pVk32K0642Kb1
 yuoaUOm2sd2IE3yt/HHUuesYyEJs6z9KRVLLKqxqFE4/2U6h67Oxq748EutzNWnIRv2JlpqaqS
 SNIOWOjl+TND1ltTtw6LFhZELqO4k9GjDDFARmdBRbNW8K4Q/PzrwUh5WMW0poZr4a6HaJIkBt
 8BD3QOJ9IKKgy5jAfpMrljvjlssCD56vJwKncJdvJ07JpfORgJsVlu90yZ3zJiy2lyWchE5otq
 S2I=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="169530877"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 15:44:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMhCObtx1p+VDdH6aCVYdgR7z3ycNe87rpuuafiOl2laJVWZk+dLIabG1S1ohkvs18YIgtGG3jt9+rdxjWA7qsVjjfSMN087kRh+97ovXKw2nU3TdeEMDfOXWaHmC9IXc+8fqLbvQIchyedT8UEA+NiBlfADZqmy39K/AdamgEZ53VGW4F1+vZIqgkRjPTEKEeaMrabo7rsSy/5UkDDAlNQIffUpxKnj8XvvgfNW7OcWBJu01YhBHoX2D+NrC5Y1yYHH8gDWrfVA9rUVVAJPvNz062xtUSzfjoRmAXM74g1pUTaf3Td8cxHfjwWWJxtKa0XXp6SfQAJiKHOZCUWnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inakm0xEq4NH5bQ/q2vWRdCiocyC+jw84yrUbcGIRBo=;
 b=TPVbxdKUFtugAmNoPbLr7ZDT6A1hhkGjPr79Z5Av6zjfi3aj1BZjCRg86OKOBwOeBRFHSewL49yNYhd1rkhxp1hMBtPPpegCRhPlCNop82aabLR8DfWNNF+V/HyTJtVpBeM54T/1Br5aLvJiV1UC914nrQxN8zWG/RdrOrGEAuVXjKPkmocO9AvjCiN2J+csQzWKFJ5IIvBWF9vexpAz+zdzGLSoQZdxqqe97G8ImXYOhXRzUNJP5N+p1bMyPPInxlKWLfr0lxcRUozNFo2jT9y8v5iN2r0HbyQjb1XuI1MuEUPgoPG1yvjpJStCzpD0ZjijCy/NeE6djdlDOewtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inakm0xEq4NH5bQ/q2vWRdCiocyC+jw84yrUbcGIRBo=;
 b=uBJGDWxVFNGB2myw49JNcalMm/Y/AK67i0S+yJQevNJA0W8tzQ9FUxV9RPaNQHDKY7LNSot9BmXLaJhfDrEtmqlkXuYLsFRkxp82vY5mKVDbme2DU8XPLbgPUGs4m2AJAwDjFF3WXp7EZ7hPKhVcvweH1zgBJHaOJI7m/FsXd2Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 07:44:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 07:44:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Topic: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Index: AQHXTiFEXNaFexnNjU2Pxag8tm94KA==
Date:   Tue, 1 Jun 2021 07:44:29 +0000
Message-ID: <PH0PR04MB741628EB9F56A1B5843FA3B69B3E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <20210531185826.GF31483@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:843:dd6b:c1fc:a5ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fea74fc-d831-43e2-42bd-08d924d116af
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB71607D3CCB0E985D926388B89B3E9@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWEqmQ73pZ+/FJrnBxADkspetGt5R3uBNbavYFF6Pm98YHqc8RieCiVgfP54uFSk0rX+0krkmVbUsxKsgIl/ztqd/JpE5EzgzmvjZXFzEU4BXw517jVzV6OlmMqXc+deQaKY7qhX3Am1dmhClhf2w7SIHfSjEMwsX/KVHchg3NXsmAlFH5lKUdJcEnvhpMmIbs2AD43/m30+cx2n6SwG0peEYkETLpJb6pwpK7G+VQZQ85EiAd+s6YFzgk7S8RB1TqmqgTVDQCccl4bPkMDyPsXbZaAsWcfBSU3QZptQkynu8eMgrqZc+RvEbvcV2AccEYi66AN+55BC2rQQNTrMAbguwd4lhHhf2b5akG1oz0TINzEQUxCrrPqzHKdHdW5QIqjtun3SNsuRfHK3yqLY2Ql8c73OlrRbugSYgQBJl4Qsq166zHUtZI1rM4bsEZRSehc2/2Pcn6a9ETIP8YqGMXqSlIlhyrKKKTOIEmZYcdQMNLxHadivwHCOaISUTbAbOMgEagas7NgF1jbiuABmqmgHdoIlbSlFijTXOkArds0w5HJonEsxqCZWI9XT7pIm3hrjsk7cVYaT1QYKtHmnQo+1zTg4D82oDwAHH9uw3S8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(122000001)(38100700002)(8676002)(71200400001)(33656002)(76116006)(9686003)(316002)(186003)(6916009)(2906002)(83380400001)(86362001)(478600001)(54906003)(52536014)(8936002)(53546011)(5660300002)(7696005)(66476007)(66946007)(55016002)(6506007)(91956017)(4326008)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ONC0YTikKQN54LLntn1ID85NIf8kTBcUC9eNcdP7QrM+BgtslnJDsghOwqJN?=
 =?us-ascii?Q?T6jexgvadlN1nItUcI9qh/zjhdei/HQFouqGpZSPXVWLCiAWmA3TgfIbt0ni?=
 =?us-ascii?Q?yZOPP6lYU8EDPmhXnSxh80fXU7f23sAOCpL17cE9JStS0YE1EjYzNJHU3MeO?=
 =?us-ascii?Q?UU6lGNpd7XgH8VmBlQVM3fTQa3KTcfsjTxp2HyTnQ0C3Z10vrGaH81FmfqxY?=
 =?us-ascii?Q?0BnlSVLr7e+GfO06mB3FHOUH944A8D38Edrau0Gkkw1VdzGLEOFknbyWuadY?=
 =?us-ascii?Q?+kUOF4iApS18TLUz1y4EVKbQhxWIeVBlvOrP9rKkkx8nuS0j6yV4Q4QSdbnp?=
 =?us-ascii?Q?r1T7uDf+sDoM579gqMDBz9RclIOUQ3ip1wExI5P3r9Vk5toVikF1mezx7AzH?=
 =?us-ascii?Q?ZVcDiXxJy3J59RAqBKnRZPdVCnsO+Ppai/qpHM6PhxMqcWiikoJ3oBQpP0uh?=
 =?us-ascii?Q?fZn6r7lPvevfZExA7SEgc0bNHO94AI273ySaa42vgMqUj5CEfY78HCTx6mrt?=
 =?us-ascii?Q?Y26eiPglDNBCcp3+Dw47tSGZ3wlhv8ctDmx4Xkx+I2Dg64ITMY4yAmODye4I?=
 =?us-ascii?Q?6K7hcS0ZMzneC5dHvtT3UiIC8J+PcdaWMZGDWuGRtmpuW9GiU7dbXOfgGpmO?=
 =?us-ascii?Q?fl5yAaWZvi+yRx5Dcq4uF4Fi5yBF6XBzPNCqE0vv40a4xclIQROUn4S/eetI?=
 =?us-ascii?Q?u7aFr48vuIBmhTJUKs4ne8fNuF7x827TV6JhGO8NZAIJ/+StgCx3Y15Afwva?=
 =?us-ascii?Q?6MPFU1rVCyQsxSqdqFvbuz7daHUXHA0q+7CL3BMzUbnJc8xSq+YX7ggA/2wG?=
 =?us-ascii?Q?15AxbZ0zVB/Kud5Mycz9zhJ8HV25TpfrxFVfbK+9jEtK4bivwUEn4N9/qyj1?=
 =?us-ascii?Q?ipGUIRVcsg5Q+yY2hDNrxUXI703CvHhuYyFID0swOLrahaeSfRiFGjzwT9Mv?=
 =?us-ascii?Q?6FYx9YB2YxZkWpDljh8CysWl5WRShpQ1VuQefiUK77WSvTrewin1MQ3/jjKW?=
 =?us-ascii?Q?3VuP/MaED9tl1iaM2leh0f1jcp8st4dzSaFsxTohrhln8v17Kd9V74bUK9VI?=
 =?us-ascii?Q?7uLUZfz9gzpgefW6BAe2tf1yrGnEJogGmClSEyJcm5id4RARjI+GGBwg6Ycg?=
 =?us-ascii?Q?sM1SKVnOyRoNEq3LQ/tZgEBMbUdVpL1PLSKBRLgh0AxROJivBrFsYF3FWnMg?=
 =?us-ascii?Q?oA69AnYMOfazhtMlfYV1iaLWNiYruRyJoETz/UeGsVhUZLuK7Nycpkbyis29?=
 =?us-ascii?Q?7HaimlaDjiXHkjZ83IJ/FhptiLQbAHv8znjKe6bLd3ShKoqJ0Yd5gQYW1tPy?=
 =?us-ascii?Q?Iu0cfl2R3ZppnZHLDbSac801u0u/AYYFc3GgOcJUBScXb1uTnOl0mgKw/7SU?=
 =?us-ascii?Q?ADrsaqUKx42GcjTjsiTEpsJTk5ek?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea74fc-d831-43e2-42bd-08d924d116af
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 07:44:29.5780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxoAWpdA6zsfQmcDItMV3jTOAkROz1yR/Hri/DQhdQPLtRymBHXUXDW9DEdFYjEkrg+aK7UV743TRVLvZ9DP83quFybTc7wClqR1uFB1UXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/05/2021 21:01, David Sterba wrote:=0A=
> On Fri, May 21, 2021 at 06:11:04PM +0900, Johannes Thumshirn wrote:=0A=
>> --- a/fs/btrfs/extent_io.c=0A=
>> +++ b/fs/btrfs/extent_io.c=0A=
>> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(s=
truct inode *inode,=0A=
>>  				    u64 *end)=0A=
>>  {=0A=
>>  	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;=0A=
>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);=0A=
>>  	u64 max_bytes =3D BTRFS_MAX_EXTENT_SIZE;=0A=
>>  	u64 delalloc_start;=0A=
>>  	u64 delalloc_end;=0A=
>> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(s=
truct inode *inode,=0A=
>>  	int ret;=0A=
>>  	int loops =3D 0;=0A=
>>  =0A=
>> +	if (fs_info && fs_info->max_zone_append_size)=0A=
> =0A=
> Do you really need to check for a valid fs_info? It's derived from an=0A=
> inode so it must be valid or something is seriously wrong.=0A=
=0A=
I thought it was because some selftest tripped over a NULL pointer, but it =
looks =0A=
very much like cargo cult. I'll recheck.=0A=
=0A=
> =0A=
>> +		max_bytes =3D ALIGN_DOWN(fs_info->max_zone_append_size,=0A=
>> +				       PAGE_SIZE);=0A=
> =0A=
> Right now the page alignment sounds ok because the delalloc code works=0A=
> on page granularity. There's the implicit assumpption that data blocks=0A=
> are page-sized, but the whole delalloc engine works on pages so no=0A=
> reason to use anything else.=0A=
> =0A=
=0A=
