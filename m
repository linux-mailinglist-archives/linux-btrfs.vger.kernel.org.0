Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12C3BC64F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 08:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGFGRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 02:17:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27990 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhGFGRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 02:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625552080; x=1657088080;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6QiJ9U5+FyEawPZUm/x+KdcPfy6/J63pW2koqoh/wOY=;
  b=ESplAvjp1SKBc9RxQsY2lq5giuiwtY7ksD4twzRTvdnhXOBygUmFNf53
   8JyIxB9+myXi4SFM3P4bcbot9c3isjOqNBGvEeVa+kOeYHmYDQuZbhvb9
   3C2tlU4go+8xVfblJ3v8P0qqmT1u9HHKHac2GIASx2kkl/jVfDj3s/ik+
   MKnexJDVyLNSvyI23vzqBhz8PssATJF72G1rYOr703lqvAQG+phPjkUXx
   aaJgrGfyKQo7pxogPRAEE/MOZyVVNCI93zxjKI5F/BzacZGfP3zxTO+MV
   6YJ5djbvj1b6gl7AHZCNUz40rH1om2R+stea4Du4RKKTQ0mGEyvlAh/Pk
   w==;
IronPort-SDR: ClaID+E0MePK2iI5+8CximFmeDgn2iOPj+pxxsEASGZVRlbX2zNB9zl36TxXw/bdQIAUWXl3zx
 bTHn6eSiV3iA5vjSOQCUG/fD2dRyNSJNsbtjYS5+lcE7vNk/24l0NGgxPKaCEnHl0S11UPVWsN
 PFo6rzcMArfSHa+GZD4ll8DLXm8Ek8wspcRqiP0aWqPM594ZU372iOWWoMhN4n8LMV5F6l13lh
 ev11F0z23rrfe6lgZGzT5Sqdf5+eSW0fRbpzzdt/JFnMAX5t6v26ewZ/DIqLiX0OmPJ9cEP+Wn
 HmI=
X-IronPort-AV: E=Sophos;i="5.83,327,1616428800"; 
   d="scan'208";a="173039050"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2021 14:14:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnX91EMykPbkXw46GCtnpSgp6c5SZOgT7iy6vS6VvKdi1lvtwVe41QmmAwbB+40/iAYHpjauiisnRcAjwl9nI5mPewtH+ATx8WcHcf5z6mlz6OC1er/B+eDFExV7/p5CmI4LsqhQ/RBJMf1ysQMnswJAQDYnMKYPS3oK1h1rTFDX3gNj6MY+uv7ZYyJCECK0jqcl4OyBKMHs2eUipMb7L5WwTG4inFmHK32uO2SPbH707kshPGbFrQKYVUlUtX8NPrHZehph/rIyYFglyuiD+SIEx0K28404nFCvXiQVbGMob0/JfKDdBV9bnfJ08FS7XAs+E0bG/YC4ueMVNVjPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QiJ9U5+FyEawPZUm/x+KdcPfy6/J63pW2koqoh/wOY=;
 b=cJHlW9V8+8php+/klK7SKpoPRCEz2ZQeR489ZQSs7mDEX9zX8Jaiecli3AKUzmAp9GBJ2XG0NgRzi41zWzmnAm0jAGf9LP7bq0X2ZAniYpnnsyRTClJRY8ttzTBuADX5xOKkKF0wkp2AYkZHDE5mwvp6rjQId976YTu5awqTHpcXvxkSqdF+I5UYagds4yVVi8o62+JD1UxdnJtN452RQOhcJKLrmwwXtn5kzIutKn8z/ruH1l6FN8GFt+vYRyUA6BsU9sK1aeMtNgBmsSEPbIF/zRqCu4guLljzRE1zyv83iKhU1gSFK/peNm0ZMicS359RbDU8Bj2kwt83csWmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QiJ9U5+FyEawPZUm/x+KdcPfy6/J63pW2koqoh/wOY=;
 b=K4fFhZFWXFSnTd1wBdJKKbZQDfikkVUXbKEcWdknav3iFXt00VzDi7UOOwWo49ZvjY7KApDO3X5ynu09lHHBp4wdAw0+gxbuK2ayTq2f8wETfgFqyoastDu5pQE7Ca7ue5czA7zygB7EzYTjbnRXjYfYRlLjNFp2EAOJX0BDRhM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7304.namprd04.prod.outlook.com (2603:10b6:510:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 06:14:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 06:14:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to
 macro
Thread-Topic: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to
 macro
Thread-Index: AQHXcMzoYFMxhoxMEUGTH/xW3RlIbA==
Date:   Tue, 6 Jul 2021 06:14:38 +0000
Message-ID: <PH0PR04MB7416055C3C4AC524B8F5CAC29B1B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1625237377.git.anand.jain@oracle.com>
 <0ae479ebdecf5501937b5d93449a782d96864cce.1625237377.git.anand.jain@oracle.com>
 <05870252-7ab1-0306-7360-a6edeed2b168@suse.com>
 <a9f156a1-354b-6555-ba71-da6c92235d09@oracle.com>
 <7ba26789-f98e-adb2-a6d9-7979e519e802@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1473812f-3fb9-4081-c3d5-08d940455613
x-ms-traffictypediagnostic: PH0PR04MB7304:
x-microsoft-antispam-prvs: <PH0PR04MB73049F36C9E5D7C009FD450D9B1B9@PH0PR04MB7304.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cyqTzFiwdXHRP3L2iSoEVoZw3XpDF5ZzRkHxn9dSE0ySVG6a0ET0OhPHSkTQQ9UUK0ZNO8EcIFsoaCU4l09udQWwVjx4ygYOj3VTbn3ZjhMhYDNnEtWQXRXQhMRUXgFsN8cdV5NmgM2h6cnYqVZrFZZoaEXlkBe9GDDtu7iaJ1vT0Tmh3VvqpDpluxgOq4zt6mRdqpPxhkb0dSQYmRDS878Ljv/6nmOPIwsmFu/RAwVVuYNqOKCufgITqHoeNyDVL7rKIOjrUvky1z89azf6V41qsgJgewcB7Fbuya70kyPHEriaiPxk3ts+8/gvvuMlICtVRxBq9w+qVCmTLZta2KS3FxHn1sonjgXhTcfpjpwAq3fjGF1GdozXvDRUmNATUoCmLbxgu12BXohesNfcvRJDehR59MjJAAXonQVJELtmhRMmZWKr8o2155ERqDZf2X/jW8TspB04IZPeroj2sl58KwVQu2gpl9f9E1f4zC4mIapD6/8pqkkwchuXA81zZ4jwEWWW60UJBlZq+vqj2CL0oW1uJofbjbpbCgfTON7Tj2tYwH6hJuJ+lXaZDb6RnRfkxWKAg4aqNGbzwM3DYxyMUA9RLweDwXYkXm/pAwj1EpKtm4f8btgYYv/UB5/0pDrgiGd7opMWUvoF0weEmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(122000001)(66446008)(64756008)(52536014)(53546011)(66946007)(6506007)(478600001)(2906002)(55016002)(8936002)(9686003)(66476007)(7696005)(86362001)(76116006)(8676002)(186003)(91956017)(38100700002)(66556008)(71200400001)(5660300002)(26005)(33656002)(316002)(4744005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kZs5eWbZ0GgSNXB2mS8LLnvu160mbhKnPpx89GoZU2BSMnTHA2Bre5uulnQ6?=
 =?us-ascii?Q?SVO4C6FDE2P8vR6i4dDP0dMKM8gYHaBbd6lSy6PkM+lMkQXDeVOukqT5gUiB?=
 =?us-ascii?Q?qIyDtbl6AtlTd7Ng/VuUmW7HflfPZeXdRST82P5FAWwM+Vk4teY9qf+TtJOg?=
 =?us-ascii?Q?GDEBQHJOCEqJL+k1jGNS4XZs1E5vBAPf++Yd90kzXkZiO1EPb61Ewg5Sl+qQ?=
 =?us-ascii?Q?6IlWSRG651REbGstDVJKwwXL4nLyeZ+m77H25QHgSb7BH1EaBHnlXjQAk1UW?=
 =?us-ascii?Q?XDqhYE3W06gPOXMJcuEZawlETgoUq2K9zEDPtm2krtC7s1Mn5/dE+9X/9CHh?=
 =?us-ascii?Q?ZfLnXSAuTQUJ9K9CSXm1+N2rpfrjFuT3HQneyAQ68JtDG98v0woWT3hW6UAP?=
 =?us-ascii?Q?g1bOPrgrLnlb/RKnNqav5hhf4cltB7Pj36W3yx64Roh7NStBSd+2mtox3h4k?=
 =?us-ascii?Q?iMv+VXAnIkSyzEqpBQfEN2t6QvPgjbmxhLpdC/orwDoTZ00AnVEknuXpN1z4?=
 =?us-ascii?Q?COpyXYMNAs1YrBdOiLQZaogjQXyw50g1C0EkT2TRK1x939PKEXTgLDlyA34T?=
 =?us-ascii?Q?CZH3+wGcZ/7nuWRoQ4gmOoC25a91KmJNq7TJxKNuQthtpNxGsTFATSIZ/S6g?=
 =?us-ascii?Q?0/vN6WK6Dr6wwuzd2aMh2oJEr8v/iK8jQ8ZsD5P4g+tUKzfQsVM1zZ4tVrH6?=
 =?us-ascii?Q?Gnpcczr12+P/8aPnmOcCS6nPzBYMBNbynpgDIOncKuP4KD18xJ8dUWDFvFVB?=
 =?us-ascii?Q?JPcCoYCJmVg7K0q8txMDly2iXeyjm7O2fKcbbAKMpVDX5vjQmvdb9eOYXNnM?=
 =?us-ascii?Q?PYK+IgZRbNLDKoV1H14lOvKSOqQj0eIE6WfLJtWGOkUdyhcDfRFWS7rjEujK?=
 =?us-ascii?Q?yWyJ/SPZHDa53bJAVKNfPcH8EgiyjKfhCrdTZm8TZ73bvI85BpKoHdRx75j0?=
 =?us-ascii?Q?a+oTXy1xJfl+4xGqOhJiiUUQfrJdNk3+lsVxO/6z6t3FZ6Ok/IiP/A2zYOwS?=
 =?us-ascii?Q?SKPwACQ1hT3oZ44YAM/5iDSCR6rWqpc0pag0NZcgbb4XYwhRMDP1/6bFu4JH?=
 =?us-ascii?Q?3RvJQhG07Q5KF+gU9K38Fv5OeyWynX/acMcv9PHMp7fbZGwuPMYSz6H3qY3j?=
 =?us-ascii?Q?DmQb9kHYVIesbqZs5kC4bczjzn4AKUuZWBdVcv0TGMVG9ikQB6TTDLFbGfvP?=
 =?us-ascii?Q?kR+nsDo5mnoK5JRdI79fpeoiI17Lh2thNH9MaCm8q3MnHRxPydvCrP3rmZZo?=
 =?us-ascii?Q?m5Z3Uvz4aZf6numkVn/LfRDqgkABrq2fm4pNRevwWQaRUH0bmqdNp11aJGgZ?=
 =?us-ascii?Q?NabCXyx3CCDnzwZHhNSsLl/a?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1473812f-3fb9-4081-c3d5-08d940455613
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 06:14:38.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzPbPFxUI0u3kw1fqu3PCU+Rk6Vse/AJ3k6K3+UpQlrOu1w7Ts14nulRmCnpXCPHLRBNmOjsBmjg/T49E+pNLl4AemU9FlV8dwQzUGB+WoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7304
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/07/2021 07:29, Nikolay Borisov wrote:=0A=
>> The gain is macro is guaranteed to be inline-ed. A function with the=0A=
>> inline prefix isn't.=0A=
>>=0A=
> In this particular case it's guaranteed that the function will be inlined=
.=0A=
> =0A=
=0A=
And we also get additional type safety from the function, which the macro=
=0A=
doesn't provide.=0A=
