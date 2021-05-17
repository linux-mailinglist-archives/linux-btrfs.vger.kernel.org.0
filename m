Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54210382580
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhEQHmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 03:42:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57069 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhEQHlj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 03:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621237223; x=1652773223;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rXGns7Ag4J8qlZjOd168AgsgbbLk10BYB5hxl+LpeRo=;
  b=isYFqiEKYfvUkvy7NOPPBQ0ZboqG5lNfXbP6D8UQMpnepMdjJVgDttsl
   PNHK8QlkGhXAf/4f7TJXNucVScSTkiVQc6oMyJy5n+OtKr4ZDTBrB/8c8
   y8TJ9agD0EAxM13UrFml6NrELArtuaNInZBTxZD0p/ckvSMZy72GMlkuS
   X4eoqRH2x7oCe/KJjcE5pNFhOWK/B0gcRxzNQrWd7Xe1fWeugBFIHcpn+
   lY/fCyZTF/eR3/6lAmb59BbqZ9vdMSuqANHLx4BKD0cLqUL2WP/+uqQzo
   KPsqqiqCNGHAw/Bs3BjtzakCUtLwLbzEX+aNlAcvYThUu3qAprevFrDug
   w==;
IronPort-SDR: 4nbSXiCU2m20LhQbK+4PnQjC0ppmSog+GT+J6j34ZN14GsvC8fjEcMre0yrspU+3OiOBl+CQN3
 FoYwpuSHRuD/W0V6cw19Vpqm/2jsA9TvKpXsP5yOoZtj5ilw7UuN8D3rlLCqCU1GDmh7g0324C
 Mb7b5gBRN85mPR6qpSGJCapfZh0Wesc77bqfBQMCJJMIdd0cFMDfqnyzf6hhDQEhWcpCOIlrW+
 Nzalvmhgc0pc8hdxupKHq1gzfB//nMhE4DnxGH7vF+OCGtcHYQJl0DMx4Ay3jDqEKMhl8SD2vW
 nOA=
X-IronPort-AV: E=Sophos;i="5.82,306,1613404800"; 
   d="scan'208";a="173038724"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 15:40:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1oPqADwQwXc/Rf7VAMPJ+qcPKSdzaL/h7tvULw40QcJv/TK90kCxZWAsM6dD2Thki2tBY2IeZ7wAojOsNLP84kmZR2bWMIDcCo+Gy6XCQYVxgHuuWcrSb6CurMf3el8N9nSU/0MmyYOHQ6VkQwCyK3c4AoKtnn4K/Gk4cPRb9vKEutJWUYnRvkhDd/nvhXv2eOTrWins6Dv4x60GbYv4LWYy8nxlJN+LTZisJcslRnCOU2M5mM+wQJzSblvE53LfTR63bTXeuH7TZqcW4SoNSjh4c/YAyec9R+pJG8sCEaEMlXfWJsoackOixoQF+uhP7auC/cHwsFiNvP4/k1VRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUuZdZhgbqcsZU9+oMkCr7C28uKn0IqzZTU96hoNV/g=;
 b=BIdYA/ibUez2eIk2sU6TR/nV4euntMg45+HC3zSLT8F4u9k0Qs+bHY6MO39Tz76d6NYeJ6oGT+zGpVkBreWQiDiu+clscclPFTVVuVrtFDF5mzqihAwGp47aPHMcopDADuewl0Y9vLLJl9I2AllOUVXlgGCY5jMpoJSOwehTWeYa0HzGIkln4pfsuJR4k5vfNgyAG66SqpSmEf5eymThCOitMV588AIuUhTPywDaaeh8LRmxI5cVScTNL7QddaLSmWRD302GM6xpU5gIjnyNhM/7Hthl0aPxiyDaBNDmMKN2MLZuD0mRnoZRU24BZ7gZiV97i18o2dK8BnshdulJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUuZdZhgbqcsZU9+oMkCr7C28uKn0IqzZTU96hoNV/g=;
 b=YRO8qTf6Mwsgr0VbPep0X8OYqBjbr56q4rpJ3bXZ1yFsBKmi7jmseINaBlK9LyLWFlv65UGvviPbxDgAmfTNb7MQeLeISE9lB7S8KErUu3NENL9cOceO47NTnG/a79n2a9jMnHiuQ/qlm9M97NRgKe/aPGSqsUV/aZUUuW/j1NQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7685.namprd04.prod.outlook.com (2603:10b6:510:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 07:40:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:40:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: check for minimal needed number of zones
Thread-Topic: [PATCH] btrfs-progs: check for minimal needed number of zones
Thread-Index: AQHXRwPeNAVqoOeoTESU5UkfnVBC7A==
Date:   Mon, 17 May 2021 07:40:21 +0000
Message-ID: <PH0PR04MB741698038BC5AD962CB5742B9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
 <20210512141928.rkk4jt6wn3uegvdx@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:9ba:2a4d:8d47:65d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4db4142-e3d2-4f79-c1c0-08d919070671
x-ms-traffictypediagnostic: PH0PR04MB7685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7685E918B7F28EB9F9478FAD9B2D9@PH0PR04MB7685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8TE0pxwAAa8UrT25QyOkxhS8VW6rrC3N9rymqh34gvDIC64aeic79MqSICKzW16V8OWQJjSgTXWp9rtqsgneczPbcHr5smwgUHOxahy/trN4ddvRLdLQ9qXSZuQ5SxgmwhHZ78yIBacVKpKt4+v8uSJIMpGsyRB9fDI6yca9wx7j1QIYTqc7g2Q2nyR3p7zPPvCEqD4xR54KsRlcoTazEUoo3cc5VieaBGimcNOYwqkui/nuriYyLOV3PGPZaQsdZM+31G+bnWKneZ6i5OrcAF2z16vxcXWoUEhilMW3FJ5VR0qypkWIzyZoL7vDPkf6Q6VuuV5jW6BXTR/PWS1FsmUGenO+sxcHnvfJIeaEtwGjaDa+6GJn/LCBcFVVXQJYRqSMfb8fiO7tYZbnglFv0hYwVx/LaoS2t16x5Mrzy+99HCbWuuKlVgzPDC9MXzHNdwlrJIcIhJD2htMuvlzS0rpPUKbfKEwDN+CUqzPDHh1PNGs8kD8KZ4WcH+D5UY7BPtWnkvd8r+/fYaA/ja3V4FdVGJCpKWfVbY+7Euks77+ZsF78Bqg9ylyNtGRATUtegSjSmkieD6KiFkMmo9UpByM91gB0yuh/wyOlYaD7yE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(5660300002)(6862004)(86362001)(66446008)(54906003)(66946007)(66556008)(66476007)(64756008)(8676002)(186003)(52536014)(8936002)(6636002)(4326008)(478600001)(55016002)(2906002)(76116006)(91956017)(9686003)(316002)(33656002)(83380400001)(122000001)(7696005)(71200400001)(38100700002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s/N35ZPf6OeUTneQb0futgSmgqQKNO3sKCPAmuBSHMcPYcS5oLv6llgEQd73?=
 =?us-ascii?Q?SVlsEK86NfY8h9llIUtSCkTpDZoYK8KoS1wKHws4MxpIqoeULnN8WGLsv36o?=
 =?us-ascii?Q?infAPkAOxAhlZRcpVzDBfH4LRaHB9Pl7kcpZHQ0EFnrvcpSFyCj70FpjuCQV?=
 =?us-ascii?Q?D9Jt7cfjpD716NhhG2lu1ZkyEZm48HH0MC5jAAsTOpNGmwp+PAJRAdwHg2aN?=
 =?us-ascii?Q?f9UR54JnztTrCDipVjQcCU25utTyUaMTb+uMUalMdTFkqAq032H4+HpGbFXS?=
 =?us-ascii?Q?rxjSUtpEFnqyDKsKQ2uZf2Xao+FVxWl8TKgHidr9SGUbc10lbPP1E8mNxVmZ?=
 =?us-ascii?Q?QYDxnDjW2z9vwcjzybO1ltcDY8nZP8fWAy2M68SmKe6hnoGdp4KsDHf21Dh0?=
 =?us-ascii?Q?/q3JNwsovUM9NPOjFrkirBfNlvJUmVDSZUDncOIE7zeLAbhZMm3tRMjhVnxv?=
 =?us-ascii?Q?RXB3lS6klpx6gCZ4SnUzHmPniZ1Unhcc4Ajz3ZFdWNxrNZshBemwwoFBHe+r?=
 =?us-ascii?Q?B8JkmojCnXImUwmnOolHv/IKlaqq93KoLyq7LOiuwHyIKyLTrcVxn3j+heml?=
 =?us-ascii?Q?NsBazD00iuHGgCUw2Iwr6reMJwZxJCabqiYt4n+hqttRea0z69zot1a7M//0?=
 =?us-ascii?Q?OIS8hDCabYdK1PB9JPo+fLY6fs1jZlJZgNN1+acPCYsa/E5BF9coURoSz1dc?=
 =?us-ascii?Q?LCfg2H63M75TE1CCRG6/9405lXmGemmplWB3O9xZnGfO8VcCWN44Ondkzpa6?=
 =?us-ascii?Q?m+IIxT9UWDdy7hoRFEGqisJgXtUNDiouAj3rdJ7Yfwg73R0qLtSkrf7EzVzS?=
 =?us-ascii?Q?EcgYg0umivMmEpQkXqWAyjSMvkPEsNot4gGy2UHBirXGvZJij8ogC3D6uhRl?=
 =?us-ascii?Q?qmYzZ3C2+efUs3qSSt8s6JtZA4wwmRFV1aowS+osOisepsP05p4ZRbO2Z0wr?=
 =?us-ascii?Q?OQVlgRDZQWrH8o40SjsFPa/pMnycUT7INQbWjifm8szaIToiuQ2V5XyJSe1Z?=
 =?us-ascii?Q?a6EshTFOWAjG7AogyFt/prS4sakZjcCivrTsZBk8EdjDxHyzVCfIZJeXCPBT?=
 =?us-ascii?Q?LgBSZs9qU8jqY6Saa1+ihjNlXp69Jatfl3Hi8mzoe6gbZcg5LGYNknLzDZt4?=
 =?us-ascii?Q?gXb4BExYFkFX/1sId9s8BXeccHTGWzS1xVx7BsftXA2/cDuC1Wi+UX92U7jw?=
 =?us-ascii?Q?/PxikzODwvO074yuHFZryC2txKaAJ1U8GBF0IobVNDvaMIotNj5mvSSIe2TX?=
 =?us-ascii?Q?4S3PdV8FYe4CSc/xS32ddNxhYldjljXlQ4+Qk1GmVIrGnz05k+iZI3qh0u7Q?=
 =?us-ascii?Q?h/GM3LYY6Af1aVyGO10wLNKKXFj6bX5tV6wd7FSUBNVnRvHBHXcGdrO4AyHl?=
 =?us-ascii?Q?6W7t3WPsBWgmY/LBKymVi66B+oCo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4db4142-e3d2-4f79-c1c0-08d919070671
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 07:40:21.1925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5Ha5rnsDHYeVuzRBi071rn1WiNuqTkcInq7geYW44SLOLtRn5uw1LwTRwIJceoMI7R0bWTEMElvt+Cw60Axb3FD3Ihq+ivv2FycLsfjDGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7685
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/05/2021 16:19, Naohiro Aota wrote:=0A=
> On Wed, May 12, 2021 at 04:53:05PM +0900, Johannes Thumshirn wrote:=0A=
>> In order to create a usable zoned filesystem a minimum of 5 zones is=0A=
>> needed:=0A=
>>=0A=
>> - 2 zones for the 1st superblock=0A=
>> - 1 zone for the system block group=0A=
>> - 1 zone for a metadata block group=0A=
>> - 1 zone for a data block group=0A=
>>=0A=
>> Some tests in xfstests create a sized filesystem and depending on the zo=
ne=0A=
>> size of the underlying device, it may happen, that this filesystem is to=
o=0A=
>> small to be used. It's better to not create a filesystem at all than to=
=0A=
>> create an unusable filesystem.=0A=
> =0A=
> We also want to think about reserved zones for regular=0A=
> superblocks. For example, with zone_size =3D=3D 16M, we reserve zone #4=
=0A=
> for regular superblock at 64MB, and this setup require one more zone=0A=
> to allocate a data block group.=0A=
> =0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  mkfs/main.c | 8 ++++++++=0A=
>>  1 file changed, 8 insertions(+)=0A=
>>=0A=
>> diff --git a/mkfs/main.c b/mkfs/main.c=0A=
>> index 104eead2cee8..a56d970f6362 100644=0A=
>> --- a/mkfs/main.c=0A=
>> +++ b/mkfs/main.c=0A=
>> @@ -1283,6 +1283,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)=0A=
>>  			min_dev_size);=0A=
>>  		goto error;=0A=
>>  	}=0A=
>> +	if (zoned && block_count && block_count < 5 * zone_size(file)) {=0A=
>> +		error("size %llu is too small to make a usable filesystem",=0A=
>> +			block_count);=0A=
>> +		error("minimum size for a zoned btrfs filesystem is %llu",=0A=
>> +			min_dev_size);=0A=
> =0A=
> This should be "5 * zone_size(file)".=0A=
> =0A=
> How about extending btrfs_min_dev_size() for zoned? Then, we can avoid=0A=
> repeating the size check code.=0A=
=0A=
I'll look into it.=0A=
