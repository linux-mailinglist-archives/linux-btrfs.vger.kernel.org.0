Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC83A4234
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 14:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFKMpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 08:45:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7581 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhFKMpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623415394; x=1654951394;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iwOvsPO87thUEY0Wn57+uuw0jns8XIpg4R9cj8eE094=;
  b=kewlOBuP+jCLGfoZE5s0In/3NWsmu6WTbFMQcnVz93/AZS322mLE5CMt
   KDsFi1ky5Pxpne7go4FYyRGxyP3MwXqLR5VBuLr/frvQ+kMP+izhE5Vfr
   AIjb1baCP9TKQxNb+a3gtP8VODh1F4SGPwH5BNZpjHH2p64TlMV+dH3jy
   UJmxGG9UbiEqLAn5/eW6+6md5mqcxlmavshwZFIa9kM3AdGjcg9BeHwua
   NdAjUyaZFPeSuIlWPzkg2ZBSx7BmoX49gpuyLAltwLUqw3HXFsI82Ljjb
   piVEkLrJkkqsUmEex4M90FRSOFQ6W+y0yfLpjNdsL7wtsy0AvYlaKeHRc
   Q==;
IronPort-SDR: fDgFktSAW1diW9jSyj0o1+qC0EfPuZtRejqs/0aQlzibiY6T5BU37M9fyYi9k+6IJq7wa7T+yZ
 8pSJHmQSOa7smKufg4vwdV07Y5pPYCBG6rUSNt0txvnOfkj333To10TQ3jFgcnOM6Uomo2OMtg
 d9/vr3rCSJWCGiSOU6ub9SXn+KstXSFRSUAy4/G3c+J5V0MWyVQJ6Y7mj//jUbVDf0r4SqaYIc
 LyY03Z+WZe+qo9oqAcF6HMyuEUu9lZfVu4YvoEigOMued3G4KjygojoRGKiY9l1ubR/QNaBIhe
 u+I=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="171599040"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 20:43:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+/HCzKcEx0qO4b9+canq23mJjztwVn4touY7h9WL/728mohaqHY5K6ClbBVnvYGHw4gOdm5U2IKy8LuRfc0dCsVvHu7++V1peO618m74kfYFRNb5lkkOXdUJJ61Fb5cdHf4+KWhuQ2trl98BpxqJa7NKk4nv8yfip9i1+aJDiHpM3WgWN2rPoCrGlod9dTy2E9kU8nWJbin+VNo7lq0SiSsJW0NeaG3Z+RP9xRgVQ14S8bHxPN/jj74P9toUm0S8r+JILutMNuTLWIyGj8AxnynhQ973sgTcZYM/3EJhm/TSS2JUh2djo0kzeV+fpapfAzwPN6OJfbv/EbdD+f8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwOvsPO87thUEY0Wn57+uuw0jns8XIpg4R9cj8eE094=;
 b=H+yZAF17YOWFVOhGsl0se+vBkRB3RKCZfj6Gy9hBP/0lIbNhRKhJpAwf7WBytO8CIyhvr9cCpEgv8RCRb0fpGh2k/6ctticefeMubK/kUziongrcNhTT1NRr9fmYDDuu+t+SqBXeGlLnShOPz5PQXFZ9QFArUYUh0HJQMHvaOxC2R6d+Lwg95hdCRnPVTbzUhsnMw7dzvVP6wRnHtMOZP15rZwWGUTt3zxy/a0gtwogqhGZy8L4XtlapWI3l3wpk6OZWriwSGuLwsa+FnzJ89LYL1ulrHV4Fqh67Ty918Hd9qg3yJSYa0jUSqmu4Mjze1R6TgKpq4FniUvMVubNcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwOvsPO87thUEY0Wn57+uuw0jns8XIpg4R9cj8eE094=;
 b=HV9E91aMGiEF1K2gN8tM6/MFrEJ/rCw0onpXWGYeGlmgtWjK193IHBGccSJmalSnWEbsNTDdJd/4ysPHSEC5WGtuJeVrrIK4Cau8Q6FN13ipP/Oj2e2HOm1ZPCkbtXjt+xURlFzdFWYEAe3keEhiAUfYYqbUaM5IXI9RlT7ZP7E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7349.namprd04.prod.outlook.com (2603:10b6:510:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 12:43:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 12:43:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Topic: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Index: AQHXXmGkeNgEMm2fkEuHw4DggYnomg==
Date:   Fri, 11 Jun 2021 12:43:13 +0000
Message-ID: <PH0PR04MB7416A5FED7A1FC79AE25346E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
 <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
 <3542ce4c-f2ce-c834-6866-eee6c28a967e@gmx.com>
 <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
 <64dc7f0a-b0bb-251a-c7bc-553f020ae411@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c5c0843-7240-4968-5a68-08d92cd67a2a
x-ms-traffictypediagnostic: PH0PR04MB7349:
x-microsoft-antispam-prvs: <PH0PR04MB73490817889B6858E870DEBC9B349@PH0PR04MB7349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BzAeHRgwt2GjML7nHrfhmXlCuprrf7sOIdPiQduTo7VN8jYjBLK0SBTX6SV04g80v2ePwhNw4YMEy6SAc8YG3tSyb6TdYMu5ysAnGyIBZrBX+FxSdgRVYqIIdEncbYkvf+Ow4zdyTHZ4R+rpz2qt2d2DxM5Gyk2kszDx2Na05/cwn9fRCSXHZxu9fl5oH+yqyqfeEOIEnVdsriQS871QjsC1QlXYX5/99DMYxmmD+uv21G3K8W/RvglACehmtVbg8mSTCAqGd2IPiQvl/9bE1+NHPr5bTttYT5oJlph+pkqeSv+snwE8rfLrf+060mQfO2rdt5iuJte3uBeWlFqc5S40MlLvSz60h6wdjpft64O6Xm9HIrM2PMrGvgY6bT+gzxPrdpETlHqNvWPNtm1Qb08EZuPzIiBC8NBRHzXGLry0X+rQHGNCqLLDmEaF1imTZQ7x0/Fot4cl5xYMyqd1AVjrek8mVM7HbNVJAaFAhrLyHfL1p8/JCaVIRzgjTzdziwLyEkR+iyRSHT2YEaD4NyykRA91wRk4F8ot7PyxQ+Z9ewlwlF06nA6lDoh4emIXGn+jCHK8PxEL0LyRQ4eeM5j5Zut7/M9PsyGv+pWNdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(186003)(110136005)(52536014)(71200400001)(6506007)(8676002)(7696005)(33656002)(53546011)(86362001)(478600001)(83380400001)(66446008)(5660300002)(9686003)(55016002)(8936002)(76116006)(66946007)(66476007)(66556008)(316002)(38100700002)(122000001)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K0VYVWZ5NG9FTWRza1R5UiswMndVL05sbVliRjRJbHcyOUdwOG9nTUZY?=
 =?iso-2022-jp?B?VXlwMk5qZEIxaUNLaitueHNUMXQ3RWNHY2RGN0grYUdUaHppTDI3cjFN?=
 =?iso-2022-jp?B?OU1SL0hrR2RKUVI1VzVoelhiZHk5MXk2YTIwcDBMOHcybkFyNnJYSnpT?=
 =?iso-2022-jp?B?VmFmeUwraHVXS3JpV0ZKdmtya1U1RUlwVFJJQm1PYmRHdGJmQWYzNW5T?=
 =?iso-2022-jp?B?bFNxR0JXMHhrN2dwanVPWXIrTFFGTEo2dEhEOSt5cUFSMFBCQjl4Qit1?=
 =?iso-2022-jp?B?L1IyY3E1NUlGd0FVQWQ5aCtSS3g5RDdTMHBHMnNnWFJCbktGRjl0OGtV?=
 =?iso-2022-jp?B?a2pjeHJPYkpPRENtalZaQy9rcTQ0UlkyUUQxbXFRRlM2VXB3dG9LYUNj?=
 =?iso-2022-jp?B?SnJJcWVSVUMvaVlQSXV4NDI1SDZBcEpFU2JPV3NNUFdyZk11MjBmSHdW?=
 =?iso-2022-jp?B?UERGSXRrei9yOG1hOEdQaDdqWlh0dXlVYUl5cnRpT2VmOVJ3c0IwMW94?=
 =?iso-2022-jp?B?NjdOUjBJWTdkalg0TnFzR2JIenVtQ0FsemlkT3VYS1FDcWJNbm5xME1H?=
 =?iso-2022-jp?B?QTdWaWtSWHRpd05adlEwY2pJc2VvdE9EclFlb2hjRG5teHFsZnNGWnVh?=
 =?iso-2022-jp?B?eFRLOHZNdkU0S3dPVXNxTTR2bWlCOWRrWjNXZkg3ZmUzVnYvNVRNdklB?=
 =?iso-2022-jp?B?WGd4Nkt4amJpeE9hdUE4OTZEc3hnYk8rWFpGcVhpbFNMdVF3K0pwcXJj?=
 =?iso-2022-jp?B?L3R3TmZvNEtDNmxUOEhUOXlqcjZvMDA3Vk1ndDZZcnY2L0VIOEtvWGlH?=
 =?iso-2022-jp?B?bnJvQ1hZeko1THRKVkRXWHZNSUZRWnNnV3R0Y0kxcDI3bW8yekF4TWJK?=
 =?iso-2022-jp?B?L2dMOVQ4WEtKUGs4eTY2cEcyN0c4ZURicldmOUJWdU5DTWZtVW9RQkdM?=
 =?iso-2022-jp?B?Q0VCSE5JVnRWVUpXK0JwUU96bC9WYlc5UHJUazRpRzllc2RuaGw1eDVP?=
 =?iso-2022-jp?B?b2JieWVjUGRKRGxGYnU5bVMvcU5Fd0FsUHhxb0l1WGs2NWNDQkdxWVpL?=
 =?iso-2022-jp?B?TDhIbGJmMnhmNWZjQVVxc1F4T2VjUUNaMkZQUnJGd0lzTkQwcEUvbmtw?=
 =?iso-2022-jp?B?V0VHNjJzbGdzTHRuWGVEY3lSSC9kekQvUExkWTl1NFNycFlDTjJPUC9C?=
 =?iso-2022-jp?B?OGhxMU9FeWJJREFxckwrNUoxRG9Nb09IQWh1NzVYUXFuSWtwajNkVWQx?=
 =?iso-2022-jp?B?MGRXdGF2R0R3U0lzWHRvSXBsd1IySHZZcFVkaVV0L1RvQXViYm82cFFy?=
 =?iso-2022-jp?B?bU9CNnhzL1VLOWpXbmQvbURzS1lzUDNzNUk2ZjFTUnJ2MldvNXdGaEdx?=
 =?iso-2022-jp?B?bXZrTFkxU3J1d2ZmTm1LTTVZUDRWQUNsUDRVRE0zNmsrR0pQRHV5dEFN?=
 =?iso-2022-jp?B?cGNVcGpoY2VCcU83S1B3MnoxVmVveGRiZTh5c3c2bXB5MURtTE4rNHRx?=
 =?iso-2022-jp?B?bEdSSEtiazVZMW1jSDc4cWJpMWVuNUJkNGpDdmhjNGxmUFBHTjlKR2Zw?=
 =?iso-2022-jp?B?ZEhTWWRvd2UrRUdSWkdmV2JiZTNKMUk1OHMyckprWVVuWkhTWlYxeDZW?=
 =?iso-2022-jp?B?VjE5a3QvU1BSY0ZUZjE1aFhFR3EwNzdWRzF5Z0pNMUt0Z3YyVnF3d2x0?=
 =?iso-2022-jp?B?UVQ3YXFtUHdHTGRWeG5yQWhGTnFmOEtsdys4ZjhBNjZub2QxWlZNUmlS?=
 =?iso-2022-jp?B?RzNDblk4NEd5SUZQTUJiWWZ5K1NmaUhsN1JETkVUYzFmNnRtRUp6V28w?=
 =?iso-2022-jp?B?SmJJWitLc2xaN3lvNk5NRExZZzdvUGtycUM1bjFJZ0ZsK2MxZ1ZLUmRB?=
 =?iso-2022-jp?B?dHVOM3ErUFhZOG1WWEpsWTJrenFqcSttNno5V0ZQZFVwUVZCaUZyb1hj?=
 =?iso-2022-jp?B?MlE2ZExZdFBiQXZ0QkFNTitELzNoNTBWVHRWMDE5d2FDZVhkVjVpMm5a?=
 =?iso-2022-jp?B?RHduYUtpTDZGdHErVStRK0VsQ3pxWUp3Y3JNYUI1WjRITDRNM2Y4endZ?=
 =?iso-2022-jp?B?VWc9PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5c0843-7240-4968-5a68-08d92cd67a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 12:43:13.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1y6/IX9RqyCEUhUQY2m1fp0qNeeXIPZYDWVBLLyYUQsEGsbtiYXA+5JI6eSi316SWjJV55i0q/+uXEORELYtljSa8k1xyM50Jhc+WnIEMSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7349
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 14:40, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/6/11 =1B$B2<8a=1B(B4:19, Johannes Thumshirn wrote:=0A=
>> On 11/06/2021 10:16, Qu Wenruo wrote:=0A=
>>> Did you mean that for the bio_add_zone_append_page(), it may return les=
s=0A=
>>> bytes than we expected?=0A=
>>> Even if our compressed write is ensured to be smaller than 128K?=0A=
>>=0A=
>> No it either adds the number of requested pages or it fails (I think the=
re's=0A=
>> and effort going on to make bio_add_page() and friends return bool so th=
is is=0A=
>> less confusing).=0A=
>>=0A=
> BTW, I have a question about the add or not at all behavior.=0A=
> =0A=
> One of my concern is, if we're at the zone boundary (or what's the=0A=
> proper term?), and we want to add 4 sectors, but the zone boundary can=0A=
> only add one sector, and if we just submit current bio, wouldn't it=0A=
> cause some problem?=0A=
> =0A=
> E.g. we leave a one sector gap for the current zone.=0A=
> Will that be a problem?=0A=
> =0A=
=0A=
The zoned allocator will take care of it. It'll fill the zone as good as po=
ssible=0A=
or move the allocation to a new block group on a new zone.=0A=
