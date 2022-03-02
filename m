Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47BC4C9F13
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 09:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiCBIZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 03:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiCBIZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 03:25:34 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBFB82D2;
        Wed,  2 Mar 2022 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646209491; x=1677745491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vM3XGAbfZPv7es4Pqmjx3o7OJSrdDcP45nSEYKxhBAs=;
  b=k3UZkqMDLmuAlGP26WH/0sEPOpyGpCZl/lvagujg//hfEAE3hZd0CT9o
   y+nfky+uwFkANG53P4c+eWlWIbp3ywkb+LcFVRraCAIzv9KadEdTdm/TG
   9Arv2PSjlnIXFcEUxJ4rNghaGZLs82Xei9aD0d7TxF+LX6hGhxqZ2khh4
   Fz3/6TS6Z+OEEQ6HGc28LPjpbDkjypmt8kIx7whnk+HWR2aZnPQB50DrK
   1ZiUcqaIMjYoWtcKP2uQFluXe9SvIKYZ8ixvNJSj0KB0WiNea8t2Bs6HW
   l95/5gT5MAIDYAcokgX/GrB0FNp3vqG8JMBiu7B3Ukr36T+2+2ePw564q
   A==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="193201281"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 16:24:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1m2Iw9a5E1vivhQHUh0qseiYSSIyHsZMQrrBd6RuB6CrZ0wxFBWnHRKHQ1Jbeq783WIc6fgDFcFRYuLLEdMWO4i/IUdg7SOkVESD0dVGzd9XpfMfAtY3FOIxxqT9EMJF0SlzDW1ZBun1CfpPsm4SzpYyogDKDRCgw8rmyT5EAbjRqn5niASkX7IuQnPBApGNSpW3hIeRhyc6Sdd3C7NZ4LAkllTHTJv2nV45TIlTPrkDOQfvjbGRQ1q6KA8TUjUZAmJkHtwuMjg0SNxO8hagsRPr0BNiacl2mVFxH/gwjVaBUXJWnh7JU1P9i9JzO3PO52prX2w+wurL8zfpuy2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19PYWme8HSGmn4RCgrIVW2AaZPuHqa1AnuRVhSLvfP8=;
 b=XvyLAbtnh6/uhIOaNyyXSFJPRA+tCqPGs8sXvRxzi6UOndbP1JwhStHIYoDUO7RfNSRzNoe+bflJKcFvX+7XUsoZPs+NAoj5KZPDowvUzKsUp9tt8zGsMSOhHpETQIMk4YqFZl2xKJYbMd8uO1wxPRs8cWrkx6N1XdhFVCG7YgqJDk0IwIlcmCkKxeZ5af/01/1iKhjKyjYR775l+3idxGGMaM3gZ3qxoIpx18pgBbYOOytgb5j4ehu6S6aeD2F5Qmon5lSFbpUNMotZOUNimTAkDzUaU9IcMPAwJwXtItOZ3lPG1JWV8NhjcTO9mxs+n8YmjlV9DXJG1lB67MMQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19PYWme8HSGmn4RCgrIVW2AaZPuHqa1AnuRVhSLvfP8=;
 b=C5GqLhwLJHpfejFcJf4DK+44WIbm0eyGbzD38LJ1WllBLRFrwlgs0segs+a/xBX+zyex7ikEe9Vl+FcAX0hA7h1k4SttvJu2O8TY78NFEMSPhJqOmcNY++EgabxKNWJoyFkCmckJ93rcfzJqi8HZ+mY+fx2CRUMdg+e4uUV/EFY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0843.namprd04.prod.outlook.com (2603:10b6:3:f9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Wed, 2 Mar 2022 08:24:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%8]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 08:24:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Topic: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Index: AQHYLX/HTsdi+5TEU02xRSwX5mWddayrhSYAgAAc5YCAACDpgA==
Date:   Wed, 2 Mar 2022 08:24:48 +0000
Message-ID: <20220302082447.qetrvidwqlqkungi@shindev>
References: <20220301151930.1315-1-realwakka@gmail.com>
 <20220302044334.ojz2crbcc6eapvex@shindev> <20220302062659.GA1852@realwakka>
In-Reply-To: <20220302062659.GA1852@realwakka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51f66d85-5ea1-45b3-0818-08d9fc261d78
x-ms-traffictypediagnostic: DM5PR04MB0843:EE_
x-microsoft-antispam-prvs: <DM5PR04MB0843F7E397F6DAF80E949410ED039@DM5PR04MB0843.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+R7vUTr7S4+ErIdB8hm8BJeywxUPTbyHbJ0KFtSNA/XpNwzDpNZ3Bd03Ms/R0XvU8jlGR2yoiY7Tj/MgzcXN+ghDr8zfsZcmqOJ9KK7pujqvYIix1/0fPcem3tXuCguUPUZOpRBoxfTIN3c+kvboh+/saynFq1VZJ7iUdpTbspIHcnMG6fgxw1leys2OxogWlH4qgbvZqGXvqWc42RULk8Ixwfv6xOWhBvm0qwymKYSzBlGhwWtyEd8yYsB/zKlPZEdjYn+DyBxC9Azsh1lh98PkUnblr0kCJBCdW5467/axPJA5NDH1CvDeLBdzPO/3zf9sSdvPuEZef+g2qpUs5pH2TGYxFAvRw8OxmbQwO8fFegztDoa/dPhCajYwImo+JxWvrXUqv/vqq5rGTAPI9b8utfDwYir7wjDKzcJFeMKcL1Sq5HQVJRR1mJf2I0dd5nqLqvS+qZZIH2qn5TaWrp2Sg1y6CftzSPtxIhihMmhDUENzGixYiZKMyCyM4d38QfefLGZ/HzZ4f0QJz2I14oe1+YeKIohIarPK+zBnMBWXcdjaZlhmI0ehCJ/+x78sY+3l3Kzk2wFq0cJiMhTDeMylBDDgKkf9U4xtf/OsZqUE7kLlDywMnhMwRvF+erkKksdi3Rty/sYklZC9bFy36uRJFiFpdgwzO+QfL/S9eZeZkgTxtucXVeQad/YOPytl8AfxQC5F+PhpiikW0WlPYainELp4kKGKLHXtn45rAFLJ17odSSleGKK0c+tEvP1Ce+SMz7HwH5x+Qeq0JR+J+EtMcag6mEHgj0gi9vcLTnUsHvdsWAKv8rl2NA7s8F/D3lITAJH9FNr42SyUEYRaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(966005)(38100700002)(82960400001)(6506007)(6916009)(33716001)(71200400001)(83380400001)(508600001)(122000001)(54906003)(8936002)(44832011)(316002)(6512007)(86362001)(1076003)(9686003)(5660300002)(3716004)(38070700005)(26005)(186003)(8676002)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(15650500001)(91956017)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XEkYU/q4oytnzfD54SAJKARmSmqMEiQTBbYNRjLRSNbKWRTTd++PG6wUU9eQ?=
 =?us-ascii?Q?ghwINUU36VL4xOCC5HDSIbIFQ4AKkTq6VEqTVf+FQlQUjLTihdSjdCFHewnK?=
 =?us-ascii?Q?vzCcQcR8yGR4/Yf9i/cg57/G0tScAiiL3a7dMEERC0rJidnOXJi1/omuRVqJ?=
 =?us-ascii?Q?J9mb5YQeodfwY+2+byO7bn7D1iNQQLBHYx4p6qM3JAWRq7aoAITpbrQdiCvS?=
 =?us-ascii?Q?gnNlQzLUSJav6qM1yDWzdeoGW/6FE4kmiRGAZn86Jkn/8GSo1MSvrxXhuJV1?=
 =?us-ascii?Q?KebPwEw+j8Wnb0Gdf6wAZsnapUC5knb3pShWiWzkK43rG0HIaWUiBNJQea1g?=
 =?us-ascii?Q?9c2+R6RdabrzravrFsshMypB1KdhQE5bmiBPHhmsT1eftgXuD7R5j2Xj/qnl?=
 =?us-ascii?Q?ni7SYi6YhBbmldXxAc6lywPisBNuPxWzSYmku0CYoM56Cbni275NVFuqMAmM?=
 =?us-ascii?Q?5oHF0TiEg8FM2UbHHftL15UJm1We3ilTHQpg7IjUQ0wZ+23SGqtd8st8N2zI?=
 =?us-ascii?Q?kfpICDFBK2uE1i+I+Ijy0x766Izh6YpH0CFJA9UggEzGFRU62fdvDGhkOMkD?=
 =?us-ascii?Q?9+UpH2kytzTLsdUWrlaDZthbxTGL1TWO+8ZBzKPd8ObjIu35UYSqRK79i57r?=
 =?us-ascii?Q?G21n7xx+8OR9HI+BgpV10YVE9h3sCtsg7JbYqDzZjJ/YqI6LpuXQ3ltdzZA3?=
 =?us-ascii?Q?AYzExSORug0WD0Bd2fyZ64UmHdKfwgqG5sljhN43IIHM6X2RWNdTEVuJuTu7?=
 =?us-ascii?Q?1eKuV8Z+ExMX66UnpkmxljCYd2d6EoQ1Cf+srsoZrP3nq/4/uM7DlVNApTjF?=
 =?us-ascii?Q?WHZUGzKlRYhh2MbQo/jVmrmUXbMKZZDvrkCj6FUFIfQBM0rRTKpUbwfwttwI?=
 =?us-ascii?Q?afg7QIqbChEfpyvuFWXEyPiqYE2T+NxGyXFguogTG+Id9RzVNw+uBrpQFx3d?=
 =?us-ascii?Q?OuEtgLW+VNMnpC8eNhw/QgB8ghAKIZrUzd+L2YDn4ICucrIOxwe5P3uFg20X?=
 =?us-ascii?Q?193NtBnudFShQHG50F3denDF90prplV5AS5NWcP2PtWQOsluNUvwyDAlECyx?=
 =?us-ascii?Q?WtU40ODe3nv3F+G9BSPq+96We5ZPelV5EV6AGBmDqK85LzaB/OWup5VNhsTW?=
 =?us-ascii?Q?FbvF+wnDgwL+HPBYKqNH88rsNW2gaZom0TeeqFOEbuHUk2jPXiyHdWOqgUN5?=
 =?us-ascii?Q?pSKDYNj/s3PxXuabpVOwO8W9m47/7BPplurOLzBR1wa5QF0im6HS7NMNvF+T?=
 =?us-ascii?Q?pkXPO4e/3Fccr/D3VXdBr44Cc1TPQviA1wrxnRWDsd+OVjMJU4oTxcsGNe8P?=
 =?us-ascii?Q?X9YoSlpaOnLf4mzZwh8W92MywtYCEkEjbugYpL4qwpanuOvuGl/lCstBiZH5?=
 =?us-ascii?Q?93a0CQxC4ZSgaIXXV6pkaDNTXDvArxIVmqRQIXm5R6Pc0v7cxW9PrLnBUXb8?=
 =?us-ascii?Q?hKg0uTKUZbufOFauVhPtkomuYpx1fndTeAE4SANIbXGNaRkGR1QQupRLyTCq?=
 =?us-ascii?Q?wbmrF1SKxyR8ULLv48blmV9ZQQvMIyFtuAME7w20g5SgI2n32NPPjTNmWa8p?=
 =?us-ascii?Q?FQFepOKaOfKwokwOGhDIlahSDEY75S2vchJ7Huf0k8+AxZSFJQoz58fPZL8W?=
 =?us-ascii?Q?tc5sNF5ba/ePS/bHmizvp7WQVtryvtt/sXD68cvmoH6cRCJxTakdsWjGLdtu?=
 =?us-ascii?Q?u8Ufs5ETHOJhbmi993/7TD2UP3w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6915EC4DBE75D448FFD769DEE2D9DBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f66d85-5ea1-45b3-0818-08d9fc261d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 08:24:48.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzAbi9KCaNuo0w4kbRWkt1nFTgDHsyiiAuxPenxmI2/lFPEYS7pph9/bCepsaL2vu9Mt79sz7TYzoZire6e4zfDV57RLSohfDuzrqBFgtzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0843
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mar 02, 2022 / 06:26, Sidong Yang wrote:
> On Wed, Mar 02, 2022 at 04:43:35AM +0000, Shinichiro Kawasaki wrote:
>=20
> Hi, Shinichiro.
>=20
> Thanks for reply!
>=20
> > Hi Sidong,
> >=20
> > I tried this patch and observed that it recreates the hang and confirms=
 the fix.
> > Thanks. Here's my comments for improvements.
> >=20
> > On Mar 01, 2022 / 15:19, Sidong Yang wrote:
> > > Test enabling/disable quota and creating/destroying qgroup repeatedly
> >=20
> > nit: gerund (...ing) and base form are mixed. Base form would be the be=
tter to
> > be same as the code comment.
>=20
> Yeah, 'disable' should be disabling.
> >=20
> > > in asynchronous and confirm it does not cause kernel hang. This is a
> > > regression test for the problem reported to linux-btrfs list [1].
> > >=20
> > > The hang was recreated using the test case and fixed by kernel patch
> > > titled
> > >=20
> > >   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> > >=20
> > > [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwa=
kka@gmail.com/
> > >=20
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---

(snip)

> > > +	done
> > > +
> > > +	for pid in "${pids[@]}"; do
> > > +		wait $pid
> > > +	done
> >=20
> > I think simple "wait" command does what the for loop does.
>=20
> I didn't know that "wait" command with no parameter waits all background
> processes to finish. So it seems that we don't need pids it can be
> deleted. Thanks.
>=20
> Actually I've been agony about this. Does it needs timeout? When I tried
> to command like this "timeout 10s wait", This command couldn't be
> executed becase "wait" command is not binary. How can I insert timeout?

I think recent discussion on the list is a good reference [1]. A patch was
posted to add timeout to btrfs/255.

More importantly, it was discussed that such timeout of user space program =
will
not help. Eryu pointed out that once "the kernel already deadlocked, and
filesystem and/or device can't be used by next test either". IMHO, your new=
 case
will not require timeout either with same reasoning.

[1] https://lore.kernel.org/fstests/20220223171126.GQ12643@twin.jikos.cz/T/=
#me349d62ff367a0a6a28076bdd5b89263fc8109c0

--=20
Best Regards,
Shin'ichiro Kawasaki=
