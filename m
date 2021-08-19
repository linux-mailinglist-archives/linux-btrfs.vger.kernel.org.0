Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B033F1684
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhHSJq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:46:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54783 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhHSJq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629366349; x=1660902349;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0j26/YKN+3m03QdJD2ACv9nV9gTuZUm2gtXhDEe46g0=;
  b=IjBH4Sve9FJJQfQJOP1MunZpAm+MovjJIjSqnr0g+XuIAPD0nAqsRbTe
   K+pb6lAM+oWR+yviJh9CIE1ASN8AwtmH6zZvAV6Qc2czmeQTQmHCS+OU6
   1xyohHopixPTo2hI+SaC5ZCQbxrtzcGJ5CPiUvEe2aE42XdFL0NFIqbSZ
   UmyvSTasauGvOob2UEvNCDGHz/ErgW9kXa8LB08bMdUWqWZe/WQ69zetm
   l1wWpBR68Dng/ZnSklCl4GgJ6C6svFyAG0tneqq+mIfAoAxnqwQTGKy5r
   Zsghwc/+OPdiSynKiBPrxKDzhipoD0V1QUDqPVBFVnZGOA6NB+yg1eoRx
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="182548291"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 17:45:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCoTBKKqNBi4ifwXsRmzLzmpZp0iZEtsnpyD09kAiRoHT2nuTM0ZXVpcjyWQk7b4oTuIhxHSLkt0vc4aHz9IVqhHN27CGEgI567HSETXNL6HC+JSncIvR8c6cM5DWIwe6XHXLKiQGbezDqRq91GV1OHEZtVdRRKEaFoa1gHtraTcXXO4SJNkvq6UiaHnMtj15DVRNB/sb553h5mzHBOg+ETUaFjHvESQ9ITT8+dWjt/pwjb/UiJrVXoB+JqOhguglgwy4FgSFOl1iF4A+vXncTrNm1gZm6XV+QecKCG8ubNtg8IlGpATI/qCxDs4LPAoqXxiwbrbaYF/dL3ir7sK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axsHbiAB9mURKZANCc2MqCOJ3wJ/ztKXjAM3co7lfho=;
 b=GWOiTmR4u3R0ihvPhHgEB/WEYwUObmwQfZQZtmshpdYMGunmOIGV4gs7E5LgRqIFCB85dvHenIkmGnIntQBY3c933bXgBTQtRDFTvC7tC4xvUA4EiDuMLWKaVjeu6oAUnQxl8Ow7+iRQU/j2tm6BJxOU+BH4NgP2UnujSbeAC1VFz4yaCTGr3pAfU5rRbd6/LUC9moxUOm/E+O46k5Sh4q5+vCw3YCcIZB/9orDHOf/Wa//RZ17ykeWeAUORf0Qsm+X/8mvnoUt7ooug00RFtQfpH91ijF8FRyPLSDAcrLbF7cYpxHOBfzvShLIqir9To5jHv/smfV/Yik4gscCiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axsHbiAB9mURKZANCc2MqCOJ3wJ/ztKXjAM3co7lfho=;
 b=WW37TkjHh8Ew6Kyxne0bPrQs6Vj97Yf2xs2EVwuop6XzLKC30bH7umvVf7DosJAgHlbcBwaBkg5NS5sUv2j00Si3tAMXj/UVTA9wypEUZ/4T1Errt1EsIoPbTyWevZPU8EY6FyesvtTjM5QsV/T0xmpFa9jXfwgsxFyGNRJM+Go=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0251.namprd04.prod.outlook.com (2603:10b6:3:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 09:45:49 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 09:45:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
Thread-Topic: [PATCH] btrfs: sysfs: advertise zoned support among features
Thread-Index: AQHXg9HwPD1w1PYbVUCiDGAAb1CJTA==
Date:   Thu, 19 Aug 2021 09:45:48 +0000
Message-ID: <DM6PR04MB7081986D98093993EA155107E7C09@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210728165632.11813-1-dsterba@suse.com>
 <503a227c-3a73-7332-88b2-cba199fb71e5@suse.com>
 <DM6PR04MB7081BC46E02027125ECB20BEE7C09@DM6PR04MB7081.namprd04.prod.outlook.com>
 <74c98d51-8e3d-97e9-e989-1a6d3115fe6f@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d6b2b0-573a-4b2b-716f-08d962f62036
x-ms-traffictypediagnostic: DM5PR04MB0251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0251CAEE598F4AD17D29EFCAE7C09@DM5PR04MB0251.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuqvW6LmPn1XiSrKTum3xAv+rAXNhTex6y1DRpXobTEiPfPi3K5XlP2/k1hb70g9jko7CgmNrITp+p3att4wS114Ao4u8/g6svff4KN9hiPsOUjKhPzBWO6he82fQAdsYrdYcCz0CTn1x7GiI8MUkkrcG9VOMvASDefPRgKyfRf8PqIercvERmec/pTvOCNgluTx6lgC4i4CRTN4PL3r30jN4+GS6CQPN9VRFiP5EopTKy5XPjtqjWoC0pBRZZcSlE26bYKuEkyYeLn3vVAbnAHxriaTL4xt7GXPp/dPqTcdvVT/HkZOryOAR0LuBVZasmvIIj36+MOlZxx0YGpwS8c1b57jVSszoxuUR6igSzcsnxYcypym7hhF1I2t0zd4+rk6B2ONXNN8X4QGRki5BCLmYsEC1HNUxuDnzPtt4Np2TZLeCMfhvxG0eQW2Rz5Y6Ge4ZC1XQoeBAE4OF6syRZ3v5gE0mClWuH4ZzppSfMB7FTGueczhVPcJqfvBa3tG8Wk2RLtK6KnWW1NNaKVRb/eqYnB2QCHJ11IfQUb247fojC3vYRPCerbeKnJ1RqHSbiiKromJvZmFtNt7TC5e1GafDfBRaAjskToF041xkfmArbur+QMeJb1Dq0N4SLffFDgEjhFAXQZmMkmiFs0c+FhCaSWa+Z9oWkXZC/+RugqMjzwN/dualVd11PHswSodRrr7JDo3gayjy7pQR10/7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(66446008)(38070700005)(66476007)(66556008)(66946007)(9686003)(76116006)(186003)(53546011)(122000001)(7696005)(64756008)(91956017)(2906002)(54906003)(6506007)(5660300002)(52536014)(4326008)(8936002)(8676002)(83380400001)(38100700002)(316002)(110136005)(71200400001)(33656002)(86362001)(55016002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?LFqMBZbgwmYjSzjbg8NCGAiKvtdYR32yAMaotldiPv/aBUkT/rgvUKsRRjoqk/?=
 =?koi8-r?Q?d8p7je1ygUqAkI0crIC7ZCfzCEcs+eHbRL+RukAuhXOWv8PWZH7amFdp5oiRk+?=
 =?koi8-r?Q?gI7BZVx81WpbltHX/JV+DW3UXbkEvwhxgE7NKFAbkott6VDHMklE0xTnMTsqHc?=
 =?koi8-r?Q?zKrdGT2MPuHGXBofPQtviPbp1TlPE8L1TCCRfi/ArctTHclTQQTT/O709FTgyI?=
 =?koi8-r?Q?Uk+yhaZD+BEerlloy1OOtyk3g/hs/CKQ/qdsqut980vlPgQlb7aNp9Nwo49C3e?=
 =?koi8-r?Q?cshcCnIqNVwkfekQtHZzdvYmEwrZFdzAD58IM+9lQQcr6Fmr7t9eyQYyPNqBEn?=
 =?koi8-r?Q?zUpqQE9HdyxlDkU/C08kpr1LlkeYMr27xrmgP+LWQXIcyn0ElZ2S02BwEz6KiP?=
 =?koi8-r?Q?/TATZvcWiXAhTugeub4bpMbPfnkrBMtg6J/3d79CsLrTYnHJVIW6q3mZyEDzHj?=
 =?koi8-r?Q?RuATa6r2llLompTG6MJQBFhqjwyVmeFkH0CY6Z3TcjxIttZqQfSr0MMYhE8nKJ?=
 =?koi8-r?Q?7IL+odQfTo5kiRnMtyUb/eiqw3t+eqz8pIg0LNeiNL7mfl3/kC1/qT8+DX4kb5?=
 =?koi8-r?Q?8eUv/s2Gabe4ljSQQevi1AGy8zZaFTuLeER8sRZMxZtrl9vLDXNU4geMpWvFYK?=
 =?koi8-r?Q?4a5xZQYmBJlc3wUEXCeXKtuOF88WJd3db0jQBjOsG9Z/O59Y2IFz03xZUmX+qp?=
 =?koi8-r?Q?9IROIF6A1px270J22PAXZnB0KjZvjFfKXG/f0nwmb+5gG5vlqsMJV0bzLBEF7/?=
 =?koi8-r?Q?HtxShebMrVYgZZDzWnwefcZH4K86BkTash9vfEzSE2KE8JwP5ev4CjIRJ7YBYe?=
 =?koi8-r?Q?QeI1GlOwrerijZRTK450VuZCp/w+YQvzToUjZA1Ix2L6j/ozIHayBCkFUpkQw8?=
 =?koi8-r?Q?7EJuGnwMem0rBfvR44aCdiG2ssiHnl5h6zC0MBojjpQNMe4wtv3TpXKnuHE4my?=
 =?koi8-r?Q?dO6hzd7mEDgWBa2LIWwLiH1GM72ou6BfsQUC4SkJ0GUhkuq/CZcfYzrpqc8Cp9?=
 =?koi8-r?Q?fYI+Nf1WHdl5bHBnowHJqcyotANJ1TnoGQTSnMugzoe37YcUym1uhP2+RiRzwC?=
 =?koi8-r?Q?R1bAJIZ8p9KTaKhsJOO29VASsibRwbxvpnStDDo+ZcRA+dbeARUGcUpJRNA+mz?=
 =?koi8-r?Q?ofGQUH9dL+1i5ViwHhqd3rHKX5/Z+w6TZRrnG9uXi+7hCTJrwO9jSB7PEWIy+c?=
 =?koi8-r?Q?CBIGCyu0X/6GTsl/UGG7UvIK2FRE9kzLyhk9kmdI3ENi867gLqfgA5/N1uBxOd?=
 =?koi8-r?Q?J/gRerrGaCARlm0RW9qbgJjiF5zWniKuAhh9SK5mw4/zTgTVZ/qiJIOBUJyWtQ?=
 =?koi8-r?Q?xrCgaPgng2DUIvg7Q34eZx/pv2AGmDSJu4GbYPGNZUXFelPTtFs2oAs9CTNdlu?=
 =?koi8-r?Q?xf8w=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6b2b0-573a-4b2b-716f-08d962f62036
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 09:45:48.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ka8QyOraCKOljmCqfCgPoEik4KgS8xwGHnLyQLA8nKgLsNFZ1jJ8pP0Ps8VFouhyPpthE5XTsa/uXQFpCVaxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0251
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/08/19 18:37, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 19.08.21 =C7. 12:31, Damien Le Moal wrote:=0A=
>> On 2021/08/19 18:21, Nikolay Borisov wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 28.07.21 =C7. 19:56, David Sterba wrote:=0A=
>>>> We've hidden the zoned support in sysfs under debug config for the fir=
st=0A=
>>>> releases but now the stability is reasonable, though not all features=
=0A=
>>>> have been implemented.=0A=
>>>>=0A=
>>>> As this depends on a config option, the per-filesystem feature won't=
=0A=
>>>> exist as such filesystem can't be mounted. The static feature will pri=
nt=0A=
>>>> 1 when the support is built-in, 0 otherwise.=0A=
>>>>=0A=
>>>> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
>>>> ---=0A=
>>>>=0A=
>>>> The merge target is not set, depends if everybody thinks it's the time=
=0A=
>>>> even though there are still known bugs. We're also waiting for=0A=
>>>> util-linux support (blkid, wipefs), so that needs to be synced too.=0A=
>>>>=0A=
>>>>  fs/btrfs/sysfs.c | 12 +++++++++---=0A=
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
>>>> index bfe5e27617b0..7ad8f802ab88 100644=0A=
>>>> --- a/fs/btrfs/sysfs.c=0A=
>>>> +++ b/fs/btrfs/sysfs.c=0A=
>>>> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);=0A=
>>>>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);=0A=
>>>>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);=0A=
>>>>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);=0A=
>>>> -/* Remove once support for zoned allocation is feature complete */=0A=
>>>> -#ifdef CONFIG_BTRFS_DEBUG=0A=
>>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>>>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);=0A=
>>>>  #endif=0A=
>>>>  #ifdef CONFIG_FS_VERITY=0A=
>>>> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_a=
ttrs[] =3D {=0A=
>>>>  	BTRFS_FEAT_ATTR_PTR(metadata_uuid),=0A=
>>>>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),=0A=
>>>>  	BTRFS_FEAT_ATTR_PTR(raid1c34),=0A=
>>>> -#ifdef CONFIG_BTRFS_DEBUG=0A=
>>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>>>  	BTRFS_FEAT_ATTR_PTR(zoned),=0A=
>>>>  #endif=0A=
>>>>  #ifdef CONFIG_FS_VERITY=0A=
>>>> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct=
 kobject *kobj,=0A=
>>>>  BTRFS_ATTR(static_feature, supported_sectorsizes,=0A=
>>>>  	   supported_sectorsizes_show);=0A=
>>>>  =0A=
>>>> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute=
 *a, char *buf)=0A=
>>>> +{=0A=
>>>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_Z=
ONED));=0A=
>>>> +}=0A=
>>>> +BTRFS_ATTR(static_feature, zoned, zoned_show);=0A=
>>>> +=0A=
>>>>  static struct attribute *btrfs_supported_static_feature_attrs[] =3D {=
=0A=
>>>>  	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),=0A=
>>>>  	BTRFS_ATTR_PTR(static_feature, supported_checksums),=0A=
>>>>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),=0A=
>>>>  	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),=0A=
>>>>  	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),=0A=
>>>> +	BTRFS_ATTR_PTR(static_feature, zoned),=0A=
>>>>  	NULL=0A=
>>>>  };=0A=
>>>=0A=
>>> Why isn't the above hunk predicated on CONFIG_BLK_DEV_ZONED the same as=
=0A=
>>> the ATTR_INCOMPAT zoneed bit, but as explained in my earlier email one=
=0A=
>>> of these should go and whichever remains must be predicated on=0A=
>>> CONFIG_BLK_DEV_ZONED.=0A=
>>=0A=
>> zoned-btrfs can be used with regular devices too. In that case, zones ar=
e=0A=
>> emulated, all of them being conventional. So btrfs zoned feature should=
=0A=
>> definitely not be dependent on CONFIG_BLK_DEV_ZONED.=0A=
>>=0A=
>> If CONFIG_BLK_DEV_ZONED is not defined, then zoned btrfs will be usable =
only on=0A=
>> regular devices. But since in that case zoned devices will not show up, =
it is=0A=
>> all consistent.=0A=
> =0A=
> Then we should discuss what the semantics of the ZONED flag under=0A=
> features should be? I.e do we need to explicitly distinguish between=0A=
> "btrfs supports zoned AND the kernel is compiled with BLK_DEV_ZONED so=0A=
> we say we support it" and "btrfs has support for zoned devices but you=0A=
> have to figure on your own if BLK_DEV_ZONED is enabled" ? I.e by having=
=0A=
> sys/fs/btrfs/zoned set to 1 what information do we want to convey to the=
=0A=
> user?=0A=
=0A=
That this version of btrfs supports the zoned mode. What device you can act=
ually=0A=
apply it to then depends on CONFIG_BLK_DEV_ZONED. If that one is set, the z=
oned=0A=
btrfs feature applies to all devices, regular and zoned. If it is not set, =
then=0A=
the feature applies to regular devices only, since zoned devices will NOT b=
e=0A=
present. The user will not see them :)=0A=
=0A=
Rather all simple I think. But I am heavily biased with this since I have b=
een=0A=
doing zoned stuff for years. So someone totally new to zoned storage needs =
to=0A=
chime in !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
