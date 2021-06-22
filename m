Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE43B05E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFVNhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 09:37:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44078 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 09:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624368940; x=1655904940;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p9CP3agPi72Kirwc2zrxbW3FV+UfWo/iwlJv7SOFiOA=;
  b=c6xxt5i78Tfo6gOEjo4EIZuvUUqK5gS+oc604S7f1DAU7HdfD/CRfGAL
   qFhNN6nbcddAmL+WLhPzdt7WXSjFixWaAfFDjGC4my3pDxBFgF9GRtn5g
   LlvTNN/JBhqmhIsoFCTV3v5behkb/Ssfrelp5G/vRkYoylDI0Pchguw/o
   rWs/nuJFEfhi10FHdfXuLew2KPkCjAqnqMYGkaHbJbLEOPNOh6veGXwB5
   amiVphA9YSpiiWoC+zp34e1ALX7g1ELTN/2hHYzVzOJb0Sz2TSlN09DXm
   yNJYePrZ+04nBVYdOwxOH4jWAKbbeA0xN+bXw62qAxnmwtxV7pvaiTNb0
   A==;
IronPort-SDR: OWE3895QUI5qwGpWtTgxQeDduLsTFPYbBE8L2uLfYEyQDyBm8eMII45mocy2LUMw8W8ZSzlUZX
 PVnXxITzAomwMG7fXzA+AKPfVcLLVIO+6JLSWmoRTu5L1Wkv4NFNsthHV3FGvRl1swr36SV4sp
 TjoVUjg+dnomq9dawy3T+Pqx1JZhUmBrgd/2xnFko3BIDVA/XY43cqWhnyCYK7u5kw/Xrqrc0/
 44o9JxvXX+ePyhHDiVsr5mpf/4J8HHx70bIa+5YDAKc8Tr2n+dZjIkrkGgRuJ93Mipq9u8Id3Z
 NTY=
X-IronPort-AV: E=Sophos;i="5.83,291,1616428800"; 
   d="scan'208";a="173152358"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 21:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTVUYFd/Vos/M82NLtTUyfcrNpPCLaIwj6+A6BuF6In8FEGxzCBp4idOoKgWjRaL4MYmOoL9KyZEWv8s/49i6uzO/JiX9wDaeWMFHpv7i092JRxq27L2MRnGfUJhKpErWyZTgIvDj1/quTHjk0ttweY88rr5AeiYqsaY9felMBcdpvOe8pYh2Th/IkwnXhgmsULmEIHMh9CKve0XV4L4JwZLA/vkjHUCGoWQEXiPLjNrZHrQs9Mfn0h2LZ6YxuPDefEdCPsojBZTUmLBRnglIr8aUZequEYji5kb9m+IpDaPFJ+t68fu1N9Pb91nuEWQ+pGNs97/WodtaPFbddz7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE5jPJZKT5UhSsJNt3hW1DYdrft4iwaSIP0uypvcToo=;
 b=Q0a903BRXI7ZjrLr3pgt06/yym8fOhpjlYssA2oRbq7ilT+/hr+p17eS7xqqzwCT7DneWDIWJGkhlPFdwPZ702ESYet3BcQ8jmsT553JwxBTuO/hMhKMEFFfQx+2zSnJ112KaVx3ReaIzkNFznnuhkG6nxYC0Xu5uNZ8PI3fxPCMsC+ZPCjrA3dfILxGDe/51IvhdQ0GL9Ln2Dj3ChlyKuouj+zFJQ4ecXinJ/4jdvc3rVCYa1KqfyWVyhLxCwPuEwZ0QHUOs7RDuNktGE84+Lj71NiUkx5rWII7zNO8QFexhULiJ3Uj2hmcba5mVoVFYZ/Bfl5zo34a35RJVURiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE5jPJZKT5UhSsJNt3hW1DYdrft4iwaSIP0uypvcToo=;
 b=UQimqGo53pbFbBq9F/m3hRdv+hy12sR4HdCOvChP92qOxqls0WGpqU0eVvTcKEckUj0Z///9g9uGPQ3PH2f6SBixa8+MZatMTkPXz4TtX8NCbp/GlJFYCrkIV2C41KfJOjBl2TWkGNuAutSBXBDy4s8hdI8N9qBbBDOLoPrYtPU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7366.namprd04.prod.outlook.com (2603:10b6:510:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 13:35:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 13:35:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Remove btrfs_fs_info::total_pinned
Thread-Topic: [PATCH] btrfs: Remove btrfs_fs_info::total_pinned
Thread-Index: AQHXZ2pihQPLEJnm7EiusWhECW3HAA==
Date:   Tue, 22 Jun 2021 13:35:37 +0000
Message-ID: <PH0PR04MB74166672D21C191CAC62E4009B099@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210622132738.2357003-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31bfdf94-f4cb-441d-4d33-08d935829ea4
x-ms-traffictypediagnostic: PH0PR04MB7366:
x-microsoft-antispam-prvs: <PH0PR04MB7366587A63A0F8F50A4E3F359B099@PH0PR04MB7366.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNJJyb/Kna3xElvfMPdVvm6y5hSnLNVDNRMUMAVirIuXQipg04UDPP+ld2EbUUstWaHk/DwnfwS6lXntNfrXmzS5TX+mLFFgH9UN6WBD/NIBEBmGmqxD4uzS7xBVQ2kYupILOd06agIwBkTydqfHGAbQBPv86ZM1fdHO2gO0Kg0+YOnXuY/zu52rocW+8r5HQQ6MvaSlkejOE3IP+mgsUQhJ2AT1U565BNIc0lDbvOpMlDilagXu/7XXtszPR/Hjhc6f3I1eGOykoosM9vevE2TfX+LDzL38suKKr4VkYRX1WTtMxUwaTEo6JCQjPhUNhBXrxyUPWATSbOVNYv9vi+BpVZSbq3qFe7lfZIibHfhV7eRD/MbJTmMcea9JjpeS/hVC+dSttl6+yHEGLikPtKH0b2A+F00BcN8l0b3jy3invzf+htD5hUtKVzB/o7vlSFop88Bl0vqAHbggWd+BHTbSOb11DGy6iqXLNRNSfE/OShnf7LM82TU9Xqh8xeqi/Mx0sPYo90GIQble7+EStN4pHOk6c8a9l8AgpQWjLF3VK3MtVEC32knZyc0stHFQb1ijHjeURcQpC18nLziLQSgVuPpBroa6//Kd4EYXpN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(33656002)(64756008)(66476007)(66556008)(4744005)(8676002)(55016002)(478600001)(66446008)(5660300002)(76116006)(110136005)(316002)(66946007)(52536014)(83380400001)(86362001)(9686003)(71200400001)(122000001)(186003)(7696005)(26005)(6506007)(53546011)(8936002)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fNz62efVtmSHAZCh5eqYxqbfhSRgbzLP4G/XCr/u6E82I42GrhikFGGeIEVp?=
 =?us-ascii?Q?Z3bz2xV9iaJlImZZoc1OEkZgTUnZ9gVwpp7YCbzrwMFeYNW9q0iXgYtRr+cN?=
 =?us-ascii?Q?Xcya9aDvhJ6vL+I3F6zVuXpU7HKO56+MDQE6EFguFzQl7BmDYfr//hS733/v?=
 =?us-ascii?Q?qKi9Sto+X6faH3nCheC7BCjUI8aszdrq6AozolvEcF/ZvCxv2gG/d4J0JcJO?=
 =?us-ascii?Q?C6T3f9oUV4K2y818ccV050YawkeNZl5DDHRifvLVNpAyfmrjj15vY6uIiJv/?=
 =?us-ascii?Q?1/DcoB2obs/uFCO0WbZZ/JF0++U7e/B3aGO2tzGASj08uDcnF7mKkINjWUCI?=
 =?us-ascii?Q?yLaGUuN22xUNRwx0/krojoJvZz+7H9iPS0AVvhoYHJWfxPaIh2Uv+1pxf0ox?=
 =?us-ascii?Q?R9jIY1Hup7zxiD2/JKLG8F+Sfl1kvuHoKkK7kbdx7rRPYlizvt4nPppbgUDo?=
 =?us-ascii?Q?VwQ0DDqNHUQATwQfpc/AEQ0gghVKteD83ZsidPVbkhGwvrd4ftMIiOOuPbjF?=
 =?us-ascii?Q?NRTn/64kIXDUToBRKJRfO+S2ssWjJ9qYPtUF66lA9nv9IgcOoljy0OQl4xxr?=
 =?us-ascii?Q?x82n2yI6Wz7NK8NkRHUBIFKHZh3oJwMVgqgiQm/A170VpfykNtbU6CeQVkfa?=
 =?us-ascii?Q?sUCQuSM+yREqVY+yzEUDp1Kl38boAVkkrkQMeSxaGbgQ92Kfe4TdMjfbBCNV?=
 =?us-ascii?Q?movKNAUvpsz3/UF7PrKkuxOdm6ZK79CpvdAyt2BhSizp8NmBfvwI2n/ikLVI?=
 =?us-ascii?Q?cFTxuKtbfY1Uj06fxxscJKy48aYCnjwG63OxdM3nadVkxWzupNM4+WYcillK?=
 =?us-ascii?Q?uNwzPFpMVjqpIcMKWSMZU8QxW1CtE/aIaCNTZI+5K7MP6f0DLx5wTah8RiZi?=
 =?us-ascii?Q?sylf7Qw2XnT8C1CZK0swyOSvFCtsAs2b6637HNyddDpZkc5vYosL9xYn0PYB?=
 =?us-ascii?Q?OtrO1eUMPOQCYwqmGNFCg15wuiLksZ4flwrrhZ25Y3k9+DcqlHjZNj4PmDes?=
 =?us-ascii?Q?/owLmje6rVB/PfEVhkQdmugkbQLnZWPn5KlsNLKJk8gqHm2uy827VWNVXSeP?=
 =?us-ascii?Q?tAMt712qoU3RReiSlP/vOpf6cmQiEjO0UOhPHV3Fv1iJO/0JOlaFvnrps7yS?=
 =?us-ascii?Q?F5yCKMappcdReSMNpzBDYE8suOZEDG8OOAleYtlbe+e/Symm13kBVsCrW4r0?=
 =?us-ascii?Q?P4I2z7ODACiIg6wDp6JcuddsCVPzVQqLb8UresuRylMUfidDqlT8ZWgygv9F?=
 =?us-ascii?Q?UGvL3vI8itZ1SZhUMLzswLH6GiA8typ025NxcBOtOViH2nBhnhr00xxHP19V?=
 =?us-ascii?Q?vrwIAh13rNzLtElkvqcs5GJM4wATCl3GZiCrdqwJ1bOgLw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bfdf94-f4cb-441d-4d33-08d935829ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 13:35:37.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNnjdVvMtb7qtummtKBIxhB4VBc1GwAECvfIgV0e8AmXC65vRv9jH+mEFy2l+W61kV1R7bsjeZbi/gb8Yhr6seIdOYd59RK1tKzsPPIuR+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7366
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/06/2021 15:27, Nikolay Borisov wrote:=0A=
> This got added 14 years ago in 324ae4df00fd ("Btrfs: Add block group pinn=
ed accounting back")=0A=
> but it was not ever used. Subsequently its usage got gradually removed=0A=
> in  8790d502e440 ("Btrfs: Add support for mirroring across drives") and=
=0A=
> 11833d66be94 ("Btrfs: improve async block group caching"). Let's remove=
=0A=
> it for good!=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/ctree.h | 2 --=0A=
>  1 file changed, 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
> index d7ef4d7d2c1a..e5e53e592d4f 100644=0A=
> --- a/fs/btrfs/ctree.h=0A=
> +++ b/fs/btrfs/ctree.h=0A=
> @@ -823,8 +823,6 @@ struct btrfs_fs_info {=0A=
>  	struct kobject *space_info_kobj;=0A=
>  	struct kobject *qgroups_kobj;=0A=
>  =0A=
> -	u64 total_pinned;=0A=
> -=0A=
>  	/* used to keep from writing metadata until there is a nice batch */=0A=
>  	struct percpu_counter dirty_metadata_bytes;=0A=
>  	struct percpu_counter delalloc_bytes;=0A=
> =0A=
=0A=
So long and thanks for all the fish.=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
