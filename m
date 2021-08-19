Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63B3F163B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHSJck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:32:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53738 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhHSJci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629365522; x=1660901522;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=obdLgKQ4qZby9kfef1ifIn9DyK08+BdexggVf2JbzSQ=;
  b=nErzxoTrelJzPySwRxjhSdhYaQNxauWuslNCQspw2vEm7R1Nmmffs2QO
   7XnwQNC0UFSl4CZbskBY1zd7rtYhLcCHgnpXKFZhVuQndBUzbUIgeDP2k
   Q//MaMcjAwwiV+R5mIWcA1sVKIOxmixdvo9UaLOkZzI/df+T7YoslB4PI
   Eo9mh5Ma8CMrb/H/damMpNtbiF7SjAVmoFlkR41mdEwN3EaQ9Qq/ct56/
   aKQwPUnUwICyLOJvtlI5OPwi1UrGWNP9adqQ/d1IK2DJTA6dTekD6A7AU
   k3wjBaVzCliye+IsY6bxIV1zDknNc3GnkDBKKsJIz4VzwLNgSx6T/qHKK
   w==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="182547605"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 17:32:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNzstDDggRPygTzvnxxzu8L68YLlVJ9KSsw+1U0pqgnPWJ/I8DIQHB2blTKhHt2i6gpUlG1DnMry/b6vzUlWzpXPAezQyOOrJHyoWMNOC0enasJp4x+KDz4uYCXnsQyFsu9HnzgKsyBHkPfze9FMKIaaJjBxDan3elDNgSBp50hrYFMYViWVVvE5Bwvp5Sxrzxl25r6Os442r6yCUwdxSZLTJwxY7fX0tAf/qjaIIYRIkpSXp6joGPhN8AqgI6vimxB20NucoAMYYoPIBnx6Tk3yxq/ttDt3/Yoa79p3rK0/WPacxl5E0U3Snz/9GnnqdM760/+DNQY4CieEFOCYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeQFCQFHTEdDqpKSGl18VwELDU0dktDtorf8bZIfIcY=;
 b=UBrKDkzxjOkhtdNOZ+gwB8j0McuXw1LjgWfdym5mbN9i79xQVBAukPdVlSpPPEsehhIc5u/YwfFPvPpl4lR5XwbVvJeVfGojME8lE9e3Q7wKkV2qfK1xDutlCPR0RWF2ouOXHQWKZ4oQuHO+i2KbHJTiBNZBr6TmrKqZFm+AldfkkozHLHnirqh6RXI8C7FxUSOjDBq8C3WU9NhXf1yK+i3kd+KSEPWXGbM6sZgzw2sFBgMHeEcbwmNRPgZxq5MjSmTJyI59G84HUmUkb88ncyBIGwu9hus/KHh5EhTbo9iqF6bI7xmdL/PsVr+pjcyBURIoPKBsHDcnWRNv48m95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeQFCQFHTEdDqpKSGl18VwELDU0dktDtorf8bZIfIcY=;
 b=hio+pJzoRokM/Th68k+8m/bPG0pGrQjw4d8g+xK7VYk9xlr+8SlUMtcMoE6vSfqukou6t7yF9jeyqfFK7cYQ7Qovwpus4DC8TU10GbvqXHBB6Qrkclr+KGZVSkwtDDf34epO6wix8cKlrJCfstn4qfRl+K2HiwLDGr8fyN+Qswk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5883.namprd04.prod.outlook.com (2603:10b6:5:16e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 09:32:00 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 09:32:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
Thread-Topic: [PATCH] btrfs: sysfs: advertise zoned support among features
Thread-Index: AQHXg9HwPD1w1PYbVUCiDGAAb1CJTA==
Date:   Thu, 19 Aug 2021 09:31:59 +0000
Message-ID: <DM6PR04MB7081BC46E02027125ECB20BEE7C09@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210728165632.11813-1-dsterba@suse.com>
 <503a227c-3a73-7332-88b2-cba199fb71e5@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd9ce5dd-ef1d-4c87-cb10-08d962f43204
x-ms-traffictypediagnostic: DM6PR04MB5883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5883F668124BB1240B971ECAE7C09@DM6PR04MB5883.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIXzrPwCWXFEjDJb26IjHoeplODELsST8H9mh7v0idd/zrwOrvnCTsNankoRghueQvNCkJBXhTZYC/Gwv2sOElzTYDeib60URdY783FLa38gn7bzUziCQUntsoPEil6TnWsaEaXMMWHEOr5hElLQbKEzT7Hbq/V6jxWR624ivut9RQ0cLYCeVT0FJ0qx0eAk83Lj46/F8KVxiaa4ufuPt0TKgUgFozq6nca87tsWaArL7zzv46wqK/Zi1go7oUDZBhLgB8EUGggzD1+cnchnZZEMF6INoJyt+1mUMCRRQKCowBvaP9mrWXAsVEXj4SG3nU9yGAiXkiFOOa9ak03urudglgbr1Was08An1yoO2V5BVglRCFFPEg9pp0jK6kDgXYjpkyVPOPwpGG+dYrKlJLw1Pvo0aeN1jgZk3+MieALriDeg1zEjIO4lrEdxcW3bru6MHciREWXj17NscmFcVmb+EhGmBaRVnvs4c+4vMxM5az43FWZ8H8bEkN5erGsltx4czmEom6f6e/WZXEKOkpikTBPyk9OvZxVOTzMIB0ingGgfQ78XESztPLqIQPyMugz/V/w+joNGzQyKLoQDXg/pQgD62NYBvVXpu3zSKIkhVzOwpMdM+XbLKIqISD7KWZgd9n1zHpGm6Zygp2udpfbI256Pc49YUzFWfNab49LLGx4rD11RWWT1sHKgcSlPdvcfmnK5rJTdn4OKV+uFNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(86362001)(8936002)(478600001)(33656002)(38100700002)(110136005)(55016002)(9686003)(316002)(8676002)(4326008)(71200400001)(54906003)(38070700005)(5660300002)(66946007)(66556008)(2906002)(66476007)(66446008)(53546011)(6506007)(83380400001)(91956017)(76116006)(52536014)(122000001)(7696005)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?DM9wENtxxGNTII8pFC8Pmyi6a1PVSX7hgymo9yhfz9OTuA4Hl929RL1h0Pa28w?=
 =?koi8-r?Q?OeLOyHOR15U4a3pNvMq7gmufb4DEkf3aOMxaamLoDEQMAmF5R5EAX9fLOz9H4b?=
 =?koi8-r?Q?qRA9eLZFucv3DKRP3w3T00AS04sqMByYIq3jLDqpo5pbfAdXRlooomLMIXnLgN?=
 =?koi8-r?Q?4dCxiNJ0WjEgwUs44eevcLlLzJzyBPc7R9FKFbFpdnpFVFBcmZL73wwAqF7Ixb?=
 =?koi8-r?Q?iNvDRWnnRO/90nb0JWeZzRTwdKFlHfsqNrEUwsu7eCamz0b2mjTBRBXRzMhlVN?=
 =?koi8-r?Q?fRgicf/iP7fGN49vVq/+IzPbzvXjuy0yUg+cm+OJRkAfd9GiMVCIMbaUvVw7N0?=
 =?koi8-r?Q?CNc/UwA4YE/s3yNNQW83ypuf8iIrodxG4MQnA7v6VAxDQTvO9TDvqgzAtzAW0g?=
 =?koi8-r?Q?nL1lcrcHFomGDa7OVkvcbD3u6u44y6sBnAdMNKdmrgmwLo4OmKEJr0GMut2ocd?=
 =?koi8-r?Q?+VHC593GOcV1xyxXUibsQKcpbowaM45V8saO8BekKaJx9pkSJcrL8BKcKAMFXc?=
 =?koi8-r?Q?5NMPjsBqNyMg2y1wmX03bFsgWCgB39JESpXzaDqMZMa4LbgdapxN0pTdFUhp23?=
 =?koi8-r?Q?/fy1z9+WOGMYfyh/gdwMAFYoLrl6PTR0JvNAEXS4qkEFR2Nq/hAjRBGGYE93sD?=
 =?koi8-r?Q?tIJJz4sv48iq8xUfhANhwUyFboGl37IBcUw0hmGhakGt7OgOFGSyE1sisOq99d?=
 =?koi8-r?Q?Vir8Lg/wPE521AoWL01R0wpoED1ALgMb4DWzTjQScRWhpIyED52mnEEDGeNYEx?=
 =?koi8-r?Q?9hLW1yhDr4pK8Nu6dRNjeKABRdVARcIKpKCRSAKBd/Yp/ejkLZ/f1K73A4UqhX?=
 =?koi8-r?Q?T4sK3Y0iFFczUhOa5mu+/ng/vJgykqR9Xt74YIiE7noOJosyNEGbpiPDGMcA9j?=
 =?koi8-r?Q?qqMbiId2odFxXeUtQciD8Y356YqIGAyJ5uVWxdKgjxhxv0Mzf9nDnq4FaGIz9I?=
 =?koi8-r?Q?ufN+hU9I5IWkIq8oCwmAmgRfIVU5cRZRZRlOtlCmslPIsP7SOUlpcr5tsSVHUv?=
 =?koi8-r?Q?RVLVSrbCMrIv4lJIL/pvFaf8eq3nWVVE7E1k3KLA10JZwSzOHg3t8u0pqedgRU?=
 =?koi8-r?Q?LZwD8x/2/7F9qvG6krRQaR7ZrGZNMiRCCbhR8kyjwuVR66Ay+DDApxQcl2ohqq?=
 =?koi8-r?Q?7eLoZrj1PKhp0M9WOKSfTg9QrxnRYkJjxmLU6xBRDrR7ip+Pp+3qRQHBuXErpx?=
 =?koi8-r?Q?n4I1e9iuW6ztZYx1aZPNEZ6FIJGcAqrLbOsQCQlx2RVfUXFGl+8qdm06rTo+6P?=
 =?koi8-r?Q?92q7kcHSVc4+5Sx/YgyJQn1488qZjntrkW/jODUxHhjjmbBBhjo0F1A63RCaIZ?=
 =?koi8-r?Q?qgI6cosVevQY6elw0uiw2yQFuW9uzqoJ6Yi2Vg49HS2bs6xCDdwFd59wQn+WKn?=
 =?koi8-r?Q?qCvQ=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ce5dd-ef1d-4c87-cb10-08d962f43204
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 09:31:59.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IArlNvrORjrlSkl7uwut7+7DpJC3vm2WAS7yP9kBUuaQVCzuQbF/j+Ai3u87jrqgxsGwNL7/MqpJ70iehMIxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5883
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/08/19 18:21, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 28.07.21 =C7. 19:56, David Sterba wrote:=0A=
>> We've hidden the zoned support in sysfs under debug config for the first=
=0A=
>> releases but now the stability is reasonable, though not all features=0A=
>> have been implemented.=0A=
>>=0A=
>> As this depends on a config option, the per-filesystem feature won't=0A=
>> exist as such filesystem can't be mounted. The static feature will print=
=0A=
>> 1 when the support is built-in, 0 otherwise.=0A=
>>=0A=
>> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
>> ---=0A=
>>=0A=
>> The merge target is not set, depends if everybody thinks it's the time=
=0A=
>> even though there are still known bugs. We're also waiting for=0A=
>> util-linux support (blkid, wipefs), so that needs to be synced too.=0A=
>>=0A=
>>  fs/btrfs/sysfs.c | 12 +++++++++---=0A=
>>  1 file changed, 9 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
>> index bfe5e27617b0..7ad8f802ab88 100644=0A=
>> --- a/fs/btrfs/sysfs.c=0A=
>> +++ b/fs/btrfs/sysfs.c=0A=
>> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);=0A=
>>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);=0A=
>>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);=0A=
>>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);=0A=
>> -/* Remove once support for zoned allocation is feature complete */=0A=
>> -#ifdef CONFIG_BTRFS_DEBUG=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);=0A=
>>  #endif=0A=
>>  #ifdef CONFIG_FS_VERITY=0A=
>> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_att=
rs[] =3D {=0A=
>>  	BTRFS_FEAT_ATTR_PTR(metadata_uuid),=0A=
>>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),=0A=
>>  	BTRFS_FEAT_ATTR_PTR(raid1c34),=0A=
>> -#ifdef CONFIG_BTRFS_DEBUG=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>  	BTRFS_FEAT_ATTR_PTR(zoned),=0A=
>>  #endif=0A=
>>  #ifdef CONFIG_FS_VERITY=0A=
>> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct k=
object *kobj,=0A=
>>  BTRFS_ATTR(static_feature, supported_sectorsizes,=0A=
>>  	   supported_sectorsizes_show);=0A=
>>  =0A=
>> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *=
a, char *buf)=0A=
>> +{=0A=
>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZON=
ED));=0A=
>> +}=0A=
>> +BTRFS_ATTR(static_feature, zoned, zoned_show);=0A=
>> +=0A=
>>  static struct attribute *btrfs_supported_static_feature_attrs[] =3D {=
=0A=
>>  	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),=0A=
>>  	BTRFS_ATTR_PTR(static_feature, supported_checksums),=0A=
>>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),=0A=
>>  	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),=0A=
>>  	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),=0A=
>> +	BTRFS_ATTR_PTR(static_feature, zoned),=0A=
>>  	NULL=0A=
>>  };=0A=
> =0A=
> Why isn't the above hunk predicated on CONFIG_BLK_DEV_ZONED the same as=
=0A=
> the ATTR_INCOMPAT zoneed bit, but as explained in my earlier email one=0A=
> of these should go and whichever remains must be predicated on=0A=
> CONFIG_BLK_DEV_ZONED.=0A=
=0A=
zoned-btrfs can be used with regular devices too. In that case, zones are=
=0A=
emulated, all of them being conventional. So btrfs zoned feature should=0A=
definitely not be dependent on CONFIG_BLK_DEV_ZONED.=0A=
=0A=
If CONFIG_BLK_DEV_ZONED is not defined, then zoned btrfs will be usable onl=
y on=0A=
regular devices. But since in that case zoned devices will not show up, it =
is=0A=
all consistent.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
