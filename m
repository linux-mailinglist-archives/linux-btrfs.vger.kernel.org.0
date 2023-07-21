Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776CF75BF10
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGUGnt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUGnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 02:43:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D2B4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689921826; x=1721457826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t/Twk5ZhSK550RXFncUJE7W/+QkHEg4X8qKMggAAHVE=;
  b=C8fFhT7pxBjyx6zMvVeGxBDM+vZJtRBmhdF6QwyT3FNltb1IwavW07bC
   j60y9TjOuobPmRYyV3V6mGoApXG+rl44qkaI5P1HGMqIMsPuxEyAZDejT
   97t1KTY4Pay7SoqvmcqoBGQkbhJlUlfDG5H3EIQdeinj4qMYTbRN0oKsZ
   fSODRt06CgYDs9ckPMyueMJ5NnNYDkgqdcnbfHWXWGFDvy12h5Rw10ycw
   0FrVKkHdNuiZmNrfr/X/Nt2lYnAmSCkLwsgf4GeJinInnAxmMKZRAjVmZ
   kxc2gggmhIIf+0P/KMVGqp8JJxlVQkQP4JhC2DTFYZ357FUueeTrsy5z3
   A==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684771200"; 
   d="scan'208";a="237029827"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2023 14:43:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAqTlp8UIijZd+evkeRiXqDJ35fqnLSr+dK5SeENxiCCLbNzfASI+eZXqo3YmVg4ZB+RK1Vylyorw+72qtw4iWLnKPtAinKGTzWM0NyV4dJdmE7zTkFollcsJxVjXoxcgylq2kFaKQsqccIrCBGK7f9lYlalRmHAimskxSn6LL/kTCKzQBh1+riPomWlK2FPCGZM/2uX93lH0draGITn3YHaztZ6qMkGApS2+hfNoZTklJpHiNqosBpa66n1V/G6qAYSibQCf0aAZlpWuzNhgYYyJwY5WfFiRDFS8d76mEqBkyE6VuVHq7ZGqhAV2RiwQAp+onqJHb+JxA3+NT2vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux9YuutauvsOVD0MDGUZRMpQPjZWBt5x7FQ7+tnF+uc=;
 b=CH+mrmIE4cOlZbkvMZvOytuaqlXLUfd0PDdbipOTHvWY/Zg01Sw3BuidOXhOLPaCHdWYiEL3qz7u1BizxrrL6gX0szjJi2A7T9aq0AjpFbK+V9wBkerUR3BfNu1LzUjDAWHfqoUWnHvhjIqK9SwQb+dD/012k7kKkseXxEM56n3Zi1EX/uFtKnjKfPqCg0JD8+Gxaz1Olri98mt9VUdLpQZVGCeJrpLTj0Ny+Ixs2P27COCPiOdXL+V0q7mO01a3SblxJyHn/8XmCBT7ucAQbyVgcoIdV/S2Cn1dC9RnsRNdZipxlU5jQ52xtoRO3in3eT9gsZGA+uJ1xAkhdF2GCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux9YuutauvsOVD0MDGUZRMpQPjZWBt5x7FQ7+tnF+uc=;
 b=NhXMi6L25eLTzj1WcoSevoLrPrarjO6XCcPy5e1Vo04KG1n73coFE07hmviMSVjoX6TQ83lH8eWSKHNG6Tqa/Ry9fmCPJq4J2PQ2wo8gx6sqtBvMF07jWs7/qd1JvOmTnYF7ZEob1TZLlSqIACeiVrGq9z8QybkksE0yamk+KOI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8424.namprd04.prod.outlook.com (2603:10b6:a03:3de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 06:43:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::eef4:2f79:e3e8:d7be]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::eef4:2f79:e3e8:d7be%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 06:43:43 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Topic: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Index: AQHZsCIeQWf8ir9TWU2VaOAJGDS0m6+uLr4AgAQEGICAAEuIAIAFjnUAgAvQSQA=
Date:   Fri, 21 Jul 2023 06:43:43 +0000
Message-ID: <u4y2pcg46mdisjfmabfakk6sukds344lc6tywi56bgknzmd54f@553wspiky2ty>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
 <ZKf5IjoGAAdkrz1I@infradead.org>
 <wbsmajimcou2ow6s4rtzeopwvd5dhku7hcdvm2u3doy6lagvev@3kga7xlvxn5t>
 <ZKuW7IkT9wtgJXQw@infradead.org> <20230713181922.GY30916@twin.jikos.cz>
In-Reply-To: <20230713181922.GY30916@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8424:EE_
x-ms-office365-filtering-correlation-id: 70cb7eb2-5a28-49ed-c553-08db89b5d3ac
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiHm6lhf/KjddEMnoYfqVNTtJ5B203Ng5Knp94yDwnptVyZTxzE/02IMQlgiPckbkL+24LHT3Yu7TM2Bq4MQgEpETw7ZzILr99OeVu/Blk8ls2CEbAV4Yg3x806CJm1L9T20GwjTQ7A9uB1S1ls4zG/jpij0rPBugK0bYpbFb+YatgyjfrCAseNBJUTdb3HMD4e3YDDDn6/hkLgJRRZPFJCQH+Lx4ZLu+gqBMVACIjKxEiatk1l7yX9o9fEeUrzmxxZL3JFsVjZu0LN9iTttknFDuZR8SEFHKLmJUbpkofbG3jhCSNt+3TuRMZQJfZwkYD15DT8qBTTfnxhx2Ly4fXmbDJ71WTnx5lo5p0RVF38hpd1NGaEpkSR9kPvK1CNCeKkEyLQ2CiUHROGsFYL1SCOj4xNKi7PVG0J5fav7aoLjJe/OSjlKUZWWs9OcsMunluIIKWtJ4RtTGdDiE7EcPQOhssdikdBPXhE2Zdn3wGbI/DfNL++DeGXE1kXfXKYOnYJSEPzONOQ/oU6VHjdDX7Sg6qdSPbZ7aftareQIcy3RgapOhDaOJETCFKP2okGm/xluWjXuCysAaHaw4i/cEPYvPyO6mfXN1VDpB3nzFt6VeEdq/F7TGubOfNm0QObq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(6506007)(186003)(478600001)(26005)(66476007)(66946007)(71200400001)(66446008)(76116006)(91956017)(4326008)(316002)(33716001)(41300700001)(6916009)(64756008)(66556008)(86362001)(8676002)(8936002)(54906003)(9686003)(6512007)(6486002)(5660300002)(82960400001)(83380400001)(2906002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSjyA8097pDmMYwDziplzsr60v5qdFwqY70h1p55Mz8FQ9Eyni4aOHJEqo+H?=
 =?us-ascii?Q?sCODVgIewlrcxGJmpoKO7BIWFr2P286Q+HJzfaCcj9DcqSP0Dndf7sWMBDBt?=
 =?us-ascii?Q?1MbTSiKMYVGa/eWIXsFUGy28Qr6y+aSbZQKWDL1RKSZ5f9qV6q3cd/Bk7niO?=
 =?us-ascii?Q?Y48j41uz2AInR+HtTqfrMos872pn1e1G5LWYWdLzyZ+zK3JO7nnwq4jAAk7P?=
 =?us-ascii?Q?d7Rdgqc1xpDWkfTGCdlFLPYwrU4xObSh6neLC4EGWEB9u2l9mfUrTKXQp9r1?=
 =?us-ascii?Q?rteh0ZPW5KW7WL84+SCAV3hR8WmJ/hIFPjmtu+O+5pVYkNGUuQG+avS3q6yA?=
 =?us-ascii?Q?lj4ThUDI419rsHWQ7IEFFMEtE1iSpxhHxn1pYjtTnK0pMmSDoEw8YNrvvR8c?=
 =?us-ascii?Q?VgJDqP76LLRmuwPa1zLV7ESae5B72qD7Y92MsF81QWajs1XVjSscIlyKEGfO?=
 =?us-ascii?Q?V4ws6WjClfwhTcwlvCZ+SIMHJuiFBaPJC22rIV8z5rbyWopv7UHw5GhxII3Q?=
 =?us-ascii?Q?M3V9s5o6qIzKPVQJQK4dR4cokCsLKbakOp8tnAlU1UdNdXtSgHs7Xyj2NlWP?=
 =?us-ascii?Q?E5sxT3dPbU7fkjs9MDRCHyS3LVCF+kPYRxjjJphy4cq2cgymiavS6vQztvol?=
 =?us-ascii?Q?APN1e/gyADk7tjfkeFUIFT64PLPr2mR+KQf90klJaIEgc14tkcYHutsC1620?=
 =?us-ascii?Q?gmujQdsvB+ddE0aq06wNcdGQ/Va7bkiOhPLBxgNZ1KdSNNKzwbis1Lwcsfvo?=
 =?us-ascii?Q?9SDyMGjKZV/gjjtag1oSmg8uNB1eoIlm4l5ZOe5hF9kvRw/oo2vbuv1Jj7RD?=
 =?us-ascii?Q?g9nzcfE8Y08Avdj/XdmXChdseVuLKg5Km8L3+pc+a+n1ljpQFSKcHGHdeGUK?=
 =?us-ascii?Q?E0iaYE8akFU2Vyaxdvgjx10D8YLuE6SJq50hn3pgk23/23Gi5Up9ZAe6UoBA?=
 =?us-ascii?Q?VXS9d3XpOIWAw406aIq5uoVb7C3s8rwqvXJh4STBGhVBBk2rI4anevTJWxZW?=
 =?us-ascii?Q?LfrUs1w4bHjh05HYffUzgkn4HdoOnDQEakWphDkMjwEQCvKPvJYkj+ugroeI?=
 =?us-ascii?Q?BrzoYLDbR7uSs4mWfl9VuaP+TFit7waujLRbttdclIipCRr0C1jf1nfzaE9Q?=
 =?us-ascii?Q?wc5Wt/EBHvIOGM0HnjlkyiLKVO1uyzQ4tbQp3grM5gKCS6ACD6rN50COKIfR?=
 =?us-ascii?Q?bobqCdDAbpnhq6u74IPb/3Mhirw5YF8N+BU/S/tvvgGtTtK0+ec9NO4BF27Y?=
 =?us-ascii?Q?j8ghoJzl/17QMIA2irPLb2H7j/94qVqTOd0cg2sAf9Q8gwLc9sM8AodzbwW/?=
 =?us-ascii?Q?oX0p7VpEKAiDUL7dUoE8aywTWtLWA0TPBqviUSg+rWari7vXX7AWYIHt/rYI?=
 =?us-ascii?Q?j3Tod1/3hqBQOaqvfktLvYI+5h20vXZa+sNWGbLsZoZx7c8V8JToWj70G/rT?=
 =?us-ascii?Q?1kJvPRglw9TtSmELlv+jb4iB0b+a/L5Wb0zSyMhAl8Ivfws1bBxBHJTXwMpZ?=
 =?us-ascii?Q?fialqzdd0DNDnQqB6ei9fqQ+17+7tleAtN2rqjqMgjNh361ry9jUyaWHFME1?=
 =?us-ascii?Q?X4DqcyK8RVJL5pDaotPdV/mhY0JFOMwGcr+tJWeIsfdxp+pRRaJeMx7EpSCu?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B4A5A53E278FF468A07FD0050041411@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pd5B3xpQvAmGkP1yBtAypMKQfS8RrwLgrqTqZaAQ/9ZXZrcu00Hi2pvVqb1rfji8tgaF5GujQJghpoMLmD9P+/usXVkNFdsMiazIFot1n+W2wBcFlgFciK6pMbeIwX3ive8ib/hXt3ti6evxzVAk8mAKG6HcYWomJJrGKLOBJ8fMFBB7PHjiGCK55fVpk2CfEPKl/Tn3q/gavASSfOkEz1HbI0lNFdIK33YRM3JDemDWtCQd5/HgbaFISscHQrykbNYTFiYbxOGkZQL5sbwPGObx7KjeQuQ4k/H1u5j/daKExeagoliGiMWeR5lwuGnP/H0KcVX4I12kfR5tOWFtxxDxyK1mJLOwm+6anVqp/6JCbFHgAh2FkcHTjPZSsVr4ANl3s/JDYkhDkx/x5Fo+7/VOxZvoyOJH5hnfEDu5h9i+mag1pROPeYwGQtt+8wQVaE26LA1rc89QGy2dLeujquh45NUtnb01YlKSJVOfJd7H2Y5yqFhzcMDBW8T6FM8A9f7mEKBPxwoIIZ/aXUWEzRVg0LuyXdIpC/CiAt8L8GezRh0qEZbk5VoNi0+fb4OhDjxQ11PX8CdrULKhrAcEy8d9hPweYY5FrchVHmYWeykXK2NH96EsgiPGMgbFcvFHhYZenIaWj6/FDmcQ/UEIOUqwyrGYtyoZy5ras5dhS3dYXuokfm12FkuEFTuEw9RFqey//ZHNrhNY5qGvt9pQG/BvyidgbiXMO7XRCrvTnSxMaZb5XS/UKHSqIeK2OinQ9OOSdeNuENI7zw/2lINC0XdR/gAdNAHB+1Ws9IJBd+y17kUXR2OZ7x8876BbZWhdUqKER3llH1BdrTY1lB4XtYcNUlU4ZQAT0TMNCCQYPZLDuu50ai86XyGdoynb19fo1tcySTaMDCTn/AGFGVDogg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cb7eb2-5a28-49ed-c553-08db89b5d3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 06:43:43.5889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4h3dGzUhE6AxAYZpLiuUaz+qlH1/Ys+aGsU2nAbZa6wzve+pmnUhpsONmJG7xpyciRuEWfA66Uo4EOegfmy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8424
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 08:19:22PM +0200, David Sterba wrote:
> On Sun, Jul 09, 2023 at 10:28:12PM -0700, hch@infradead.org wrote:
> > On Mon, Jul 10, 2023 at 12:57:52AM +0000, Naohiro Aota wrote:
> > > It depends on what we consider the "minimal" is.
> >=20
> > I think minimal means a file system that can actually be be continuousl=
y
> > used.
> >=20
> > > Even with the 5 zones (2
> > > SBs + 1 per BG type), we can start writing to the file-system.
> > >=20
> > > If you need to run a relocation, one more block group for it is neede=
d.
> > >=20
> > > The fsync block group might be optional because if the fsync node
> > > allocation failed, it should fall back to the full sync. It will kill=
 the
> > > performance but still works...
> > >=20
> > > If we say it is the "minimal" that we can infinitely write and delete=
 a
> > > file without ENOSPC, we need one (or two, depending on the metadata
> > > profile) more BGs per META/SYSTEM.
> >=20
> > Based on my above sentence we then need:
> >=20
> >  2 zones for the primary superblock
> >=20
> > metadata replication factor * (
> >   2 zones for the system block group
> >   2 zone for a metadata block group
> >   2 zone for the tree log)
> >=20
> >=20
> > data replication factor * (
> >  1 zone for a data block group
> >  1 zone for a relocation block group
> > )
>=20
> I think the relocation should be taken separately, there can be only one
> relocation process running per block group type, ie. data/metadata and

That relocation block group only write relocated data and that data must be
written into a dedicated block group. The relocated metadata can go with
the same BG as normal metadata. So, the above calculation looks good to me.

> the replication depends on the respective factor. Otherwise yeah the
> formula for minimal number of zones needs to take into account the
> replication and all the normal usage case. In total this is still a low
> number, say always below 20 with currently supported profiles. Devices
> typically have more and for emulated ones we should scale the size or
> zone size properly.
>=20
> Setting up devices with small number of spare zones is also interesting,
> or with small zones that will trigger the reclaim more often.=
