Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92325394123
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhE1Kkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:40:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11479 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbhE1Kk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622198335; x=1653734335;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tGOy9TW3FDYu8O5nHNXJjh8xg4qPGFt8Qc6r3VZ026k=;
  b=ASldq0zfQmXaH6DWmu4CBN6bRJuFrUZv2OB9NMbPD/Z8UX0NQBUoEd3+
   aeVxhD7JvbZkakJ8OMgh6iVoO5aRI5BuhR9O40M6bSAo/XrXyq0W1rD+U
   5S8YpvTSP36y/8TJOVlQrUYZo6Raj4mFeJgnGbFxZas8jBIubyvcDNlEf
   EF/rYaE9sLbUfxG+eckfgucg9bP346ufj/aBUOMOqJ0hpBjNjgGxn15uT
   b6fLmlZkUrDhDeg5IgkwvlsdN35ln4pxxScNFRUEEcJbxf5P7YL8cQ7Hn
   lrb5EYV5Pzp7cHDb9CaSe9HdkLBnWyc9cLVfHUFx43lNYx6BgXgLZU9PY
   w==;
IronPort-SDR: upjmIIXGFoPz1WASC44fEGQzb7HUj8fvSha5D9kHRqQvpZxjmZcavLQitl6DGP0DxzKLtmGZ7N
 2FkRoyaWP5hcV175zQC8hs63TJtkdTzYQEhwSwNshLjUAJhIch+TFlFGa6xJuGX9C2s+uq4E0c
 AZtprrNmvnmJ41OKzESwQdye1x55dzz1IIbN5i3E9tP2216rhzk0OTrFPULJNPRSKbNiRPMR+B
 GH9s6Tly6JrEvNMexERr30K34KqQgDqVnfmpERIQscRIK0qPdbwuFlTK2R/U8pTeb10Ba7R50/
 RzY=
X-IronPort-AV: E=Sophos;i="5.83,229,1616428800"; 
   d="scan'208";a="170335947"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 18:38:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOI8z1VVGwEtetqDzlAr7sUoLqjY186kY3MO99jtBCl+HDb7dasQ08RVUIux0tEXYjzsjNul798JW+0rwVJXFfcuordp8EvB+t6DGcmZVXlIjyVv4Ktrd2m5wU5uI+baeatnU12OiLfv9UOjnVjliDPFxPNjhOWkBKm1P2bN05QgktZygaytEsVwf+qBfly3x44Z7mEkupitoijRuVR+qlQY45KApfNiGzyH94YDxE2whlZfIta1ddibDxNXQ9uuBUTenKOeyzdr01MHludJTGs6eJMBPMQCBjljsVoX6Dqu7LKHMnpU+DKTR9LZH/GQvvp6CjvBIkAlBLcC0qh+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJOOSgo4LrlkaBMeaFAPw32UJP6d7muFNoHFHR2Ge4o=;
 b=GOXDgKgB9AbPzFBYeP6rm16CitPq0i/lR+/pko7cXHCGtrnpi8Hj+lKKr3ps3cXPjIMrlYS1h0EjbXqhu2xu3L6cSz0sZ0lSbbwBr/qGMHKillz/hlr23IJF6SFzJkQZ+z8k0e+QwEYyiU6UYlMha1IXgYeVZAD18Fm1yOA/9DnafR9MFckqSbayusJFKMujecVn3EI6E3jqu/taKRcN0nVLtk9eDzz6LdKruFzavl6VfLz+wjSgbOBj9W3Bg0GeJ2g0RvCc5UO4YsS4xxHVAsrS57YgLnR6KH2B3pLv49jZokfKHvy7RYlaDYITQI10ktSPvbuEZi/dlgQC5L/v1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJOOSgo4LrlkaBMeaFAPw32UJP6d7muFNoHFHR2Ge4o=;
 b=Z+Y+U8L3DunxMA2er5cxZDWXCwYjo96o2+xdtRRMt0ngf0s5i7xy6650cahM/RCEvbp8FF/3EEIN1hElpuMV+0yQMgE0HbzD9Hgg5PDAoVzNo68HVoIVyYANKhNYsX4CYsYJ9v2pcfsY8oIdtnbX/kIjHDIpfswl3mrX27Hv6kk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7365.namprd04.prod.outlook.com (2603:10b6:510:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 10:38:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 10:38:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/7] btrfs: defrag: extract the page preparation code into
 one helper
Thread-Topic: [PATCH 2/7] btrfs: defrag: extract the page preparation code
 into one helper
Thread-Index: AQHXU2kr2Yc02RPkgkSlWG5h2LgViw==
Date:   Fri, 28 May 2021 10:38:52 +0000
Message-ID: <PH0PR04MB74164E50DAEFDC86EFB9F0C39B229@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210528022821.81386-1-wqu@suse.com>
 <20210528022821.81386-3-wqu@suse.com>
 <PH0PR04MB7416FBCA389AE72610B6DEB29B229@PH0PR04MB7416.namprd04.prod.outlook.com>
 <7008c54d-d5c9-3649-a03c-3f69bcedf255@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:15a4:7fd8:aff0:9452]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4689c79f-5c2f-4173-8b40-08d921c4c94c
x-ms-traffictypediagnostic: PH0PR04MB7365:
x-microsoft-antispam-prvs: <PH0PR04MB7365CD7EF15DE089D968AE3C9B229@PH0PR04MB7365.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ule3yk0qSSmK1xuZRMboukA26bsQyhROvLFDnQYBhjaMpdZAz4UA1QVMp1p82yqrVPAM2hjGG6EmvS23I8T/Ey+1JdTS/g1zaOwzQ3ys7swt4/s2cH0YOC1cZhy03VW4odFwlkXG3Qk9zujvga4DHYgDSYKR+PsoWF1RcMEM6wMh5xNbcaTzM0HFscTmxfbc3Yi/Lee0zqX5pCdKcmzFupMn1TVSY4YJMS9EdYN61TXlO7/ej1nnoPM81hTnIu0OS4EGMlOPjUeX9EpwUt5BUBy3b5wdA2QbiGTGtlFi0xs/nt3Gh5so1QHybXWsYKPXQmQysS6T+pIjTbTTYpm/zOKfomXc/vnsFzezI96PyDvESFl+DrAkdGWVdG0+OYb9MxUdlgIeVG2bFea1beErMnPyo7f2TZRZtMGDoCTqSzj5BGwy1GH1D+Jwuyw5vC0Bpbqj8gekartgqJMiq2wIEPx6bwVNMiNDr22HxqdRqbKQkG22iz1sKFBrWvltZdCF7ALEl3BSu3Ue5yn+zj6bQVLslH5qePD94yrgDuDkn5sl9fdkeh2USSgZ8g3C0X21dsS+JlP930IzRPdNnmR/hFftr3nv8YmcHZRdkvghJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(9686003)(55016002)(83380400001)(38100700002)(122000001)(186003)(33656002)(2906002)(86362001)(8936002)(8676002)(6506007)(53546011)(7696005)(71200400001)(52536014)(64756008)(66556008)(66476007)(76116006)(316002)(91956017)(66946007)(66446008)(110136005)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?ZFZ0OHArVjV4SGp1YXVrc09TV0tpeHhPdlNJVGxnMXhtSjlZT3U5M1o4?=
 =?iso-2022-jp?B?TmlyRm16YnZZTElNUDRva20vSHVtWUJwa3MyNUxHbktNK3kwTU4xcHdI?=
 =?iso-2022-jp?B?RHAvTEFLaEhWam9nWVpwaG85a2l0Um1HRXBKRUcyczdiWjZhTHg5Y3Jy?=
 =?iso-2022-jp?B?dU9wRVFsM0J3Q29DemhZeGVxYkRFdHVQQVkzOXRyM3VWUEJCKzVkMHlX?=
 =?iso-2022-jp?B?THd2eUxiNmdneHljYVpTRVRuYU9UcWhFTS9jNk1XSTltSnFWTGcyUzA3?=
 =?iso-2022-jp?B?RlZGMjQxay8zNnZpMzZlZ2NSTTJUWFB1Tmd6b25CeUt6aDJsL2VieHdw?=
 =?iso-2022-jp?B?enFGdHVHeVp1WHUvNE9BV3RGeWlLczBjVE5sY1ZFVEVvQ1lvTk1kSFky?=
 =?iso-2022-jp?B?TjFrMmM0cVI1WldjWGRzakF3RmlYRmkxYzQvR1phWDVyOUZvTWxXdmlo?=
 =?iso-2022-jp?B?Nk5La1ZRSk5kSFlhWmZmblY5UDJOZTZtU2ZDYVNqaGVlM0lXTXVveUVU?=
 =?iso-2022-jp?B?VFhuY2JzK2V4cDhRQ3JZcEtwSG1xSDdRTmljbndDVXpnendwUnp3c1By?=
 =?iso-2022-jp?B?WGczc3NUenFZNGRpTjBvOVoxQkszM3pVVVNwcVh0U3ZwbWpQTkNkZnNZ?=
 =?iso-2022-jp?B?Sy9ueC8wcHVGM2FTUDdsTUJUbmtFUStrbGRjc2ZvTHA4RTVvcUlFTmRH?=
 =?iso-2022-jp?B?VUNvaG9la2diWkxDeUpDcXNmTG1mUTRFaFJUVXpGK2tzbXlNMDNCNTB5?=
 =?iso-2022-jp?B?anJqL0J3VjdXU25CaDVRaEdzUXBpeFlzUTNTU2R1eGJESGc1S09vMW16?=
 =?iso-2022-jp?B?cXVVYVlVd0c5VTJKcWpta3YydmNTUU1vVkU4OWNKL29iNTlQbzR3UkE0?=
 =?iso-2022-jp?B?Q0xydm1WUE5RVWNDQUd6R2JYTjFiMmE0a0dGZDhscGJmdlJKN29uSGNH?=
 =?iso-2022-jp?B?c3Rzc3FlK0RVU2RPTFllUXdySVJGWkJZL3o2ai9rU25uZGxGV1NGaEFD?=
 =?iso-2022-jp?B?N3ZpS2Zya2JPU1NUYmlZQStGSlAzUGxxVS9rY0w1blUxSHBRS0YyaWk1?=
 =?iso-2022-jp?B?d0htaHBRdXZVbnh0ODNYL2N5eWpPZktvOGcxMnBJZTVvWE1JOFRRTXBN?=
 =?iso-2022-jp?B?Y3FZUk5IZlRPSWE3cEx6QU9XMGR6ZG5EMlExRDlIcTE4ODF4L0ZSWWNS?=
 =?iso-2022-jp?B?d0w1TTJhOFBySm03eklicGpNeHRacXFnc3IwVHIrVGlWczFjUjlpazZC?=
 =?iso-2022-jp?B?UVNlRTl1bVp3WG5LUWRJNmU2MmtVc1M0UDRXeEpFRFJyeVB0bGlSVTBa?=
 =?iso-2022-jp?B?SXRGNXZjcnVuM2J1RDhSTkQ1WkpzdEFGa0xTYnRhaUlwUGEyU20vb0FE?=
 =?iso-2022-jp?B?L0ZkV3dJdUZ0UGN1ZncvcWtNd0UvNEdtbzVuSVVKVngyclFJcmx3UjBq?=
 =?iso-2022-jp?B?VC9weGJtb092OFdrUG80VzlIN2NGY2JIYk5VeVVnRFFSamswcklEbEhB?=
 =?iso-2022-jp?B?L1hkdU9EMzlrUEVJUGg2T0dwalNSdXBIZlpPQk5Gc0NWT1VBWlVYbEg4?=
 =?iso-2022-jp?B?Mlc0cVB6WDdyVjFlZnZqMXlRWThMVk1yTlEwSlpwdytuWXNvZS9MSFdJ?=
 =?iso-2022-jp?B?YTllcjZxU3B2V1NOeVpOV3ZoQ0xTaDM4c1RPWmxmS1NqUTc0bnJKNUZj?=
 =?iso-2022-jp?B?YVUwM3NVOU9xNER0UVk3NEhncHdQSGRyajdBOWdBR0pWeWpyOGtJaStS?=
 =?iso-2022-jp?B?RjByUmdra3FkblBnbzgrVlgyU0Z2SXFXNUVpdCt2WnJ0N0JrUjM0NnFk?=
 =?iso-2022-jp?B?VFZ6aFJ1dUxNc1YyTXVNTUxUR0tRY0JvcWFHYVlKbVlmQVFlY3Ntc2d3?=
 =?iso-2022-jp?B?TjFkbU90azF5eGVoUXhaUG5HK1RzL3NMZjArcWNLUDVFMWdlR1JpUDl3?=
 =?iso-2022-jp?B?eld1VnkvbW9oMjl3SzNFaTFCUTlmU3ZQUmRmRDc5RVFYdnJoVWJ0dDk1?=
 =?iso-2022-jp?B?YkVIOW40UVJadTZCUmtTSnJub0IxTk5Nb3ROams2R3plUFpJejVmTkhH?=
 =?iso-2022-jp?B?S3c9PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4689c79f-5c2f-4173-8b40-08d921c4c94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 10:38:52.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6t8kJ2qZiOjWybRpaNLs28X0LOGVfcncsm31lwUXjK3HXG5YRmOuumehiUnrYBl5hdOiXCGzyLuA1NHf8mMdwt5Ir5picufyGUJ/V3yxcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7365
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/05/2021 12:36, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/5/28 =1B$B2<8a=1B(B6:23, Johannes Thumshirn wrote:=0A=
>> On 28/05/2021 04:28, Qu Wenruo wrote:=0A=
>>> In cluster_pages_for_defrag(), we have complex code block inside one=0A=
>>> for() loop.=0A=
>>>=0A=
>>> The code block is to prepare one page for defrag, this will ensure:=0A=
>>> - The page is locked and set up properly=0A=
>>> - No ordered extent exists in the page range=0A=
>>> - The page is uptodate=0A=
>>> - The writeback has finished=0A=
>>>=0A=
>>> This behavior is pretty common and will be reused by later defrag=0A=
>>> rework.=0A=
>>>=0A=
>>> So extract the code into its own helper, defrag_prepare_one_page(), for=
=0A=
>>> later usage, and cleanup the code by a little.=0A=
>>>=0A=
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
>>> ---=0A=
>>>   fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++-------------------=
-=0A=
>>>   1 file changed, 86 insertions(+), 65 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c=0A=
>>> index 67ef9c535eb5..ba69991bca10 100644=0A=
>>> --- a/fs/btrfs/ioctl.c=0A=
>>> +++ b/fs/btrfs/ioctl.c=0A=
>>> @@ -1144,6 +1144,89 @@ static int should_defrag_range(struct inode *ino=
de, u64 start, u32 thresh,=0A=
>>>   	return ret;=0A=
>>>   }=0A=
>>>   =0A=
>>> +/*=0A=
>>> + * Prepare one page to be defraged.=0A=
>>> + *=0A=
>>> + * This will ensure:=0A=
>>> + * - Returned page is locked and has been set up properly=0A=
>>> + * - No ordered extent exists in the page=0A=
>>> + * - The page is uptodate=0A=
>>> + * - The writeback has finished=0A=
>>> + */=0A=
>>> +static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,=
=0A=
>>> +					    unsigned long index)=0A=
>>> +{=0A=
>>=0A=
>> 	struct address_space *mapping =3D inode->vfs_inode.i_mapping;=0A=
>> 	gfp_t mask =3D btrfs_alloc_write_mask(mapping);=0A=
>>=0A=
>>> +	gfp_t mask =3D btrfs_alloc_write_mask(inode->vfs_inode.i_mapping);=0A=
>>> +	u64 page_start =3D index << PAGE_SHIFT;=0A=
>>> +	u64 page_end =3D page_start + PAGE_SIZE - 1;=0A=
>>> +	struct extent_state *cached_state =3D NULL;=0A=
>>> +	struct page *page;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +again:=0A=
>>> +	page =3D find_or_create_page(inode->vfs_inode.i_mapping, index, mask)=
;=0A=
>>=0A=
>> 	page =3D find_or_create_page(mapping, index, mask);=0A=
>>=0A=
>> While you're at it?=0A=
>>=0A=
>>> +	if (!page)=0A=
>>> +		return ERR_PTR(-ENOMEM);=0A=
>>> +=0A=
>>> +	ret =3D set_page_extent_mapped(page);=0A=
>>> +	if (ret < 0) {=0A=
>>> +		unlock_page(page);=0A=
>>> +		put_page(page);=0A=
>>> +		return ERR_PTR(ret);=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/* Wait for any exists ordered extent in the range */=0A=
>>> +	while (1) {=0A=
>>> +		struct btrfs_ordered_extent *ordered;=0A=
>>> +=0A=
>>> +		lock_extent_bits(&inode->io_tree, page_start, page_end,=0A=
>>> +				 &cached_state);=0A=
>>> +		ordered =3D btrfs_lookup_ordered_range(inode, page_start,=0A=
>>> +						     PAGE_SIZE);=0A=
>>> +		unlock_extent_cached(&inode->io_tree, page_start, page_end,=0A=
>>> +				     &cached_state);=0A=
>>> +		if (!ordered)=0A=
>>> +			break;=0A=
>>> +=0A=
>>> +		unlock_page(page);=0A=
>>> +		btrfs_start_ordered_extent(ordered, 1);=0A=
>>> +		btrfs_put_ordered_extent(ordered);=0A=
>>> +		lock_page(page);=0A=
>>> +		/*=0A=
>>> +		 * we unlocked the page above, so we need check if=0A=
>>> +		 * it was released or not.=0A=
>>> +		 */=0A=
>>> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||=0A=
>>=0A=
>> 		if (page->mapping !=3D mapping ||=0A=
>>=0A=
>>> +		    !PagePrivate(page)) {=0A=
>>> +			unlock_page(page);=0A=
>>> +			put_page(page);=0A=
>>> +			goto again;=0A=
>>> +		}=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Now the page range has no ordered extent any more.=0A=
>>> +	 * Read the page to make it uptodate.=0A=
>>> +	 */=0A=
>>> +	if (!PageUptodate(page)) {=0A=
>>> +		btrfs_readpage(NULL, page);=0A=
>>> +		lock_page(page);=0A=
>>> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||=0A=
>>=0A=
>> 		if (page->mapping !=3D mapping ||=0A=
>>=0A=
>>=0A=
>>> +		    !PagePrivate(page)) {=0A=
>>> +			unlock_page(page);=0A=
>>> +			put_page(page);=0A=
>>> +			goto again;=0A=
>>> +		}=0A=
>>> +		if (!PageUptodate(page)) {=0A=
>>> +			unlock_page(page);=0A=
>>> +			put_page(page);=0A=
>>> +			return ERR_PTR(-EIO);=0A=
>>> +		}=0A=
>>> +	}=0A=
>>> +	wait_on_page_writeback(page);=0A=
>>> +	return page;=0A=
>>> +}=0A=
>>> +=0A=
>>>   /*=0A=
>>>    * it doesn't do much good to defrag one or two pages=0A=
>>>    * at a time.  This pulls in a nice chunk of pages=0A=
>>> @@ -1172,11 +1255,8 @@ static int cluster_pages_for_defrag(struct inode=
 *inode,=0A=
>>>   	int ret;=0A=
>>>   	int i;=0A=
>>>   	int i_done;=0A=
>>> -	struct btrfs_ordered_extent *ordered;=0A=
>>>   	struct extent_state *cached_state =3D NULL;=0A=
>>> -	struct extent_io_tree *tree;=0A=
>>>   	struct extent_changeset *data_reserved =3D NULL;=0A=
>>> -	gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);=0A=
>>>   =0A=
>>>   	file_end =3D (isize - 1) >> PAGE_SHIFT;=0A=
>>>   	if (!isize || start_index > file_end)=0A=
>>> @@ -1189,68 +1269,16 @@ static int cluster_pages_for_defrag(struct inod=
e *inode,=0A=
>>>   	if (ret)=0A=
>>>   		return ret;=0A=
>>>   	i_done =3D 0;=0A=
>>> -	tree =3D &BTRFS_I(inode)->io_tree;=0A=
>>>   =0A=
>>>   	/* step one, lock all the pages */=0A=
>>>   	for (i =3D 0; i < page_cnt; i++) {=0A=
>>>   		struct page *page;=0A=
>>> -again:=0A=
>>> -		page =3D find_or_create_page(inode->i_mapping,=0A=
>>> -					   start_index + i, mask);=0A=
>>> -		if (!page)=0A=
>>> -			break;=0A=
>>>   =0A=
>>> -		ret =3D set_page_extent_mapped(page);=0A=
>>> -		if (ret < 0) {=0A=
>>> -			unlock_page(page);=0A=
>>> -			put_page(page);=0A=
>>> +		page =3D defrag_prepare_one_page(BTRFS_I(inode), start_index + i);=
=0A=
>>> +		if (IS_ERR(page)) {=0A=
>>> +			ret =3D PTR_ERR(page);=0A=
>>>   			break;=0A=
>>>   		}=0A=
>>> -=0A=
>>> -		page_start =3D page_offset(page);=0A=
>>> -		page_end =3D page_start + PAGE_SIZE - 1;=0A=
>>> -		while (1) {=0A=
>>> -			lock_extent_bits(tree, page_start, page_end,=0A=
>>> -					 &cached_state);=0A=
>>> -			ordered =3D btrfs_lookup_ordered_extent(BTRFS_I(inode),=0A=
>>> -							      page_start);=0A=
>>> -			unlock_extent_cached(tree, page_start, page_end,=0A=
>>> -					     &cached_state);=0A=
>>> -			if (!ordered)=0A=
>>> -				break;=0A=
>>> -=0A=
>>> -			unlock_page(page);=0A=
>>> -			btrfs_start_ordered_extent(ordered, 1);=0A=
>>> -			btrfs_put_ordered_extent(ordered);=0A=
>>> -			lock_page(page);=0A=
>>> -			/*=0A=
>>> -			 * we unlocked the page above, so we need check if=0A=
>>> -			 * it was released or not.=0A=
>>> -			 */=0A=
>>> -			if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {=0A=
>>> -				unlock_page(page);=0A=
>>> -				put_page(page);=0A=
>>> -				goto again;=0A=
>>> -			}=0A=
>>> -		}=0A=
>>> -=0A=
>>> -		if (!PageUptodate(page)) {=0A=
>>> -			btrfs_readpage(NULL, page);=0A=
>>> -			lock_page(page);=0A=
>>> -			if (!PageUptodate(page)) {=0A=
>>> -				unlock_page(page);=0A=
>>> -				put_page(page);=0A=
>>> -				ret =3D -EIO;=0A=
>>> -				break;=0A=
>>> -			}=0A=
>>> -		}=0A=
>>> -=0A=
>>> -		if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {=0A=
>>> -			unlock_page(page);=0A=
>>> -			put_page(page);=0A=
>>> -			goto again;=0A=
>>> -		}=0A=
>>> -=0A=
>>>   		pages[i] =3D page;=0A=
>>>   		i_done++;=0A=
>>>   	}=0A=
>>> @@ -1260,13 +1288,6 @@ static int cluster_pages_for_defrag(struct inode=
 *inode,=0A=
>>>   	if (!(inode->i_sb->s_flags & SB_ACTIVE))=0A=
>>>   		goto out;=0A=
>>>   =0A=
>>> -	/*=0A=
>>> -	 * so now we have a nice long stream of locked=0A=
>>> -	 * and up to date pages, lets wait on them=0A=
>>> -	 */=0A=
>>> -	for (i =3D 0; i < i_done; i++)=0A=
>>> -		wait_on_page_writeback(pages[i]);=0A=
>>> -=0A=
>>=0A=
>> Doesn't this introduce a behavioral change? previously we didn't=0A=
>> wait for page writeback in case of a parallel unmount, now we do.=0A=
> =0A=
> The behavior is only changing when we wait, we still check the SB_ACTIVE.=
=0A=
> =0A=
> IMHO the extra wait shouldn't cause much difference for unmount.=0A=
=0A=
Yes I wasn't sure if I this does have any impact or not (don't think so), b=
ut as I've=0A=
spotted the 'inode->vfs_inode.i_mapping' pointer chasings I thought I'd lea=
ve the =0A=
comment here=0A=
=0A=
=0A=
