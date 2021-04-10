Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5935B09A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhDJV3C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 10 Apr 2021 17:29:02 -0400
Received: from mail-fr2deu01on2125.outbound.protection.outlook.com ([40.107.135.125]:60897
        "EHLO DEU01-FR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232659AbhDJV3B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 17:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgNRQyg27ohTpyueGAaNmDMLVeP+Mbi3iF6BVazfl44tj0nyNRDE/EtZYU+JkC29EOj9ZsveelafG3EJMM5TMhKHUZHgAYY6rpeb100P+rAntWjkkT58G1omDTi3p+qUNPNp3OeJCEZ4v37AZMAu/wk/DmJuwOns6aVHB2bu/jyvXZOCGiN0VYXIAIzH3iCxCFBAVXkCzcZJW21Qs8h1f45N3fyeAwctNVzkM/KRwAw6ApYr2e4ewvsbAWfokACHEToZXXg2ZytFoG6DoPvYeTmaF4u2A5mrQkyURykV2w/ALz+XwpbKluP8njMsATZKJc3Z+hAWeHh7c2u1tUGrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy3BDwjn6A7qW7zdyaYLYT4K1Qlku5nVgXIuHBZanMU=;
 b=A7Dz6jcKgqEAEOUdux+mczm649FeRadckyouUjCCu5F09pOR1Y8oMMSiI94znp8dPWYE+H+KrDzLsA0PbkMyOOevgzPqf9uot7EEqMJ5C/E1qAVq+KcpQijbzJ3NkAQdKY901OycR+yq4PtjUqtL11Yy1aBSQzGvG5CVX2vPC2wUqvBRR9d6aRv/2n/OKH2rO7MoTZyUur5eAriAaNFxZ/idrShneWB2XYDAXZYE8xapydd1QNkQL3fWnzcg4Ez+aizMofWF94k/2OJBnCbewQ9hRsxeXRgg8cEwF6/JWrHDymeZm2IwpTs6FY/b1wdVXL0fyc787/J05tWdjUK2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onlineschubla.de; dmarc=pass action=none
 header.from=onlineschubla.de; dkim=pass header.d=onlineschubla.de; arc=none
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::10)
 by FRYP281MB0565.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6; Sat, 10 Apr
 2021 21:28:44 +0000
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5]) by FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5%7]) with mapi id 15.20.4042.013; Sat, 10 Apr 2021
 21:28:44 +0000
From:   Paul Leiber <paul@onlineschubla.de>
To:     Roman Mamedov <rm@romanrm.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Thread-Topic: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Thread-Index: AdcuC0blJlFiU0MzRl+vvJbtaBo5jAADVKYAAA1ORjA=
Date:   Sat, 10 Apr 2021 21:28:44 +0000
Message-ID: <FRYP281MB0582CFDA373D3F760D75F592B0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
 <20210410194842.71f49059@natsu>
In-Reply-To: <20210410194842.71f49059@natsu>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: romanrm.net; dkim=none (message not signed)
 header.d=none;romanrm.net; dmarc=none action=none
 header.from=onlineschubla.de;
x-originating-ip: [2003:d2:1f49:6cf0:545e:be21:1922:e184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2d0bbdf-9090-489c-88ca-08d8fc679ed1
x-ms-traffictypediagnostic: FRYP281MB0565:
x-microsoft-antispam-prvs: <FRYP281MB0565D71EBD6F0CB35A230A1FB0729@FRYP281MB0565.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jybo6TIG3A/9Ry0cOxtAJx2S817sFk3ap8cWHF4Yf+e1DZmBiwXnQFrgObZ7p3yWWYKil2qMLsidCDqN4obnd2c+fJ8yOnpeU5m6pUIukRS20GRXaX41yXg8yR8pGhQDbjDyRsyNGSnJYbw3iMdcpNsYBvEtIUPB3QY2RCa5V6jMeSWLWX+pm4I6S7WqsU9+cXaXlKG/skcBPAmhZ+iHBwuQPPvbzAJj9n8nRW9Ft08rFHsWihdthoEKwLYwHrBvN+rCgqDXLyc9N057mcsgEsSiJ0G3x8dUsxN1CzLuViBz+uDfBWL1WtqB+3wqLMrApYN32jT1zFiXcYFg9558rHL4mKzgtcO3lnsUVfB1IA2Ysqhx2W8O4laODFXaYSOD9dJErUOnPKwy9GF/jXGZ6+qyTDQa37WzHFO+bh9WUtZNxV0EbA7bqArTgNVk+fJSHmbPKJsKO29MTvbuVGQFVE1gUUxCaoh6XV+vSQVX0Xiqbum9z7vxE93fjHyoW2vmhbm6wTLKYGAwC6JmgBYSm1Jg6LVDBQmoshD+j2/QRHli/1iJWVnHs38HN+Io6Q6KwIodKIzBmFpkVqmOy4Ig3K/ue0dgCdf/VOECIAjh7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(34096005)(396003)(39830400003)(498600001)(9686003)(8676002)(8936002)(5660300002)(55016002)(186003)(86362001)(76116006)(38100700002)(4744005)(33656002)(66476007)(7696005)(6916009)(66946007)(83380400001)(71200400001)(6506007)(66556008)(586005)(38610400001)(2906002)(52536014)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tz0BoOzTlLrK6vmTMBNdCQTyxwtR8DLglXSmFVmn1BY7xEnJxoLDyty6xKOY?=
 =?us-ascii?Q?mIOVVZATNprBc1OS0vf1kOZ+3ItiCIiy4Uv/lKKrhDhvrcmB3sQm76MyFcpj?=
 =?us-ascii?Q?L6gEaQA0Izlh8H9uvPQPwlFexh1IIhiVxl+aoaw0i3yUTNsbshiFljN98ACB?=
 =?us-ascii?Q?GUP4Qo50Zllmwss+FR83yEsyKdBsbxVVmj49965zVX+22u1okCxBwhdN3fns?=
 =?us-ascii?Q?DCIihDRdqbbX0Vku3/ZNT149J9+f6S7WSwdfJZJ63Q/jLPi1KEApUE0b1BOh?=
 =?us-ascii?Q?OimHYz0pjVJp/StH3MTFarZfo0E+FT6IaaYdcXGfjJosthTua5W/Why4rn4a?=
 =?us-ascii?Q?mX9Gvo+AGe5XlaKekMcA4mX+KqdTmOumZ0u2ucXwHSpN/F5+7KLmEXowYpp2?=
 =?us-ascii?Q?VRJnol3RQqzLIUoIUbdeV2WjiDLOa/bMNOfgZkC7gX3+6Nf9Q/377soACIpa?=
 =?us-ascii?Q?fQ677GMuuOjWTdScV873pUVErg6g5xdDRXwc51z8BURm2V9ZkgZ18eBSPaz9?=
 =?us-ascii?Q?SiAYsio+eQGQo+pmfP0FKId74/kngnLq6Uds4HJyIXmsIy3ZPH/mOquKM6Fe?=
 =?us-ascii?Q?E1VahDl+yWB29Un2fb2njKFmq2+DHvoC+XoxMqrr7EmZougz4MLR9Suc4b9i?=
 =?us-ascii?Q?dxwavjjUOk14/00JqbBSN1Bwv9VEa4G1TvDdHFE7SsUmOB5Tor0DeBRFbOOV?=
 =?us-ascii?Q?0KZkyquz6neN4FZQjn7k6cdLUlyRmsrfRSJWmyCmIsxRHlhCDRXekuDxgSE6?=
 =?us-ascii?Q?aif8oAQiDZzvkmE6hAFPEgkDpzT+M2YM7DFfw1mmqOu+PPjSEjrb6lWYdqcu?=
 =?us-ascii?Q?iTJnASrt+Oha1c9e3N6Qu/x85xI2SaEGa/RSxZ4AJYvTZHhKpzaWyvAsuk72?=
 =?us-ascii?Q?82OhMQ08m/HT7nCzVmhGtgt6kRcoftXNnHKMohbqm/l9oxwkyAwx3ZpFe1H3?=
 =?us-ascii?Q?lWsir9MnFW47Z6QSFPb/Gahthw6v8WGNWVAZ2IdwRZTbrL20sfz++IPxlf7+?=
 =?us-ascii?Q?of5gUWnEKOWTg32jLyeeauPxOUpTYlyzuwue9KO/gYqRW7yGQveV2QCx5CuI?=
 =?us-ascii?Q?U2UkzA6fIzzgIig4B8Dq22U2CmATZXxoE2q8w7caEkIaf33zSt9YcQcERWNe?=
 =?us-ascii?Q?sCxq26JlfhUxGSmzwo9wg6iChujva5779YvAflJ4UJCK6egS3QKJr0Lwiz+T?=
 =?us-ascii?Q?0YgbZNZMM1q+ws9/SnRWGMZK/ba8UnXJOG3lb90VyD2CHLBPfKn3BPtFOLIM?=
 =?us-ascii?Q?g8hOL9jg6Hfqa7N4UrbiB9SNg6iL5GUa+yRcrS7B9qtc+/pDx2pDfNWa9d+x?=
 =?us-ascii?Q?1llFrChIRYPj7gIW+YgZ03t8YdjDRfxNJgOfxXh1zFeXAOvFBCd5eQiwjrOH?=
 =?us-ascii?Q?DARMESc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: onlineschubla.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d0bbdf-9090-489c-88ca-08d8fc679ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 21:28:44.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfc8b046-4d00-4e98-8679-43c06bdec9db
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pa/CMp6CHEJGSWm3h6ctJBWvu+CW2YoIRivsQrT586q3zBRFOGnlC81iw3pb9B7XRoxiE/tLLd/8OS1akZfPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0565
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Von: Roman Mamedov <rm@romanrm.net>
Gesendet: Samstag, 10. April 2021 16:49
> 
> On Sat, 10 Apr 2021 13:38:57 +0000
> Paul Leiber <paul@onlineschubla.de> wrote:
> 
> > e) Perhaps it is wrong to mount the BTRFS root first in the Dom0 and then
> accessing the subvolumes in the DomU?
> 
> Absolutely O.o
> 
> Subvolumes are very much like directories, not any kind of subpartitions.
> 
> Imagine you'd try to use the same ext4 from the host and from a VM guest,
> saying "but they both store their data in separate folders!"

Thank you for your quick reply. What you write could indeed explain my situation. Of course, I should have thought of that earlier. Well, I wanted to learn, and learning I am... I will set up the partition (again! :-) and pay care to not having duplicate mounts on different VMs. I will give feedback in a couple of days.

Best regards,

Paul


