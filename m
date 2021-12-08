Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBD46CFAE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhLHJJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 04:09:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36689 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLHJJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 04:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638954377; x=1670490377;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L76nk/cnHbnCIFI9olK4ruut0BkU58TTLQPOXsAZRMc=;
  b=oa62jRK0748VM5b0Bo1y3IfJLlWRrQLcfP64YdH1LlWkbqna6xBT90Ad
   iAvi6gJ36CrvjKLdTcEdM2HcYraL3d3o3gj9RfCXaXgQo2MECt6jDlEfC
   1S8wr4rXYD3Cf534WI45MHoWDoOoHxA/QznOQhRtqwT3MXFB5r3xb7QZ2
   +Z7V1KPuCMJjISr3SCYR28BiqcA/+oBjSphiUVHk4QTBaqvY4Q/Rw2FnD
   /vKsb9nz5rTlKkKm/WvfOqY6ceE3H49Y/mjzKOHY3SPcCrgQ5ONCSlD3K
   d7PdkuhTD7tSdekxh2dIA+5oswVy1Il/Z2bP3YF1YYQW19T5u+ucOy5T/
   w==;
X-IronPort-AV: E=Sophos;i="5.87,297,1631548800"; 
   d="scan'208";a="299574835"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2021 17:06:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEPUbitgOsNx9kkEik7klCns1Si00iFK4bGe+NNTsrsdEcViS62e4KgqTyIrRdMXHy4YDjujYcsncL8QZM9VPLjZUNIqhWbaRlqt/qhBtQ3zvWzXEICBS6xWuZqi2kq5nylJBVcuPmAd9X4qu5wVMrVnn2Z1ebVOyUvBE2kgLqiY/xuFKNCcWZdXo2n1QaE+55QsI43oekjhlFzNrY9Yzr/t8z935RXqBvaRhGGU7EnrvGnOROctGxn6AffhEPM5Pjyp83tFy6uKqyd8LCtjnXXRltYJbehYYXAjxyI491c2GXvtVqL0owM/6Su0FORi1oXu1jDrJyYh2eOj90bb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z6BexMb16+GzQZti2jFiobqcP4ZmSxlu+RscoMBChw=;
 b=CtJBMktqr5z+3doTlG+wRwy6qKVSw/cz1eGsgt9RhdvjzJZF7b1+UEZqJBd+eYQ8fTz8A1Qx0w8a8HS5kkSQLlxNVi8ID0nbzcz85UgWSzlp2xr+529DkGaVfPy9SL+ASQ15GTu37Wbmhya/oJ1dU+7Gx/gaeZU9Yn730cJ3THlhM8YWf7FGkhZpzsSpeNjpOjS+GRvC3vLNmAoSMTDxcWyVaSeyxiwFZ73ot92WPA6w101p9qtkHoxN2VeQEUP1vvsXH9R8Dr3kScI3RgJ0OqZKxa/EyTGWD7j/4tvVWmUcBzM13KPsYb7UJB2cKlLRmQORInJJipMncY6mNoBDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z6BexMb16+GzQZti2jFiobqcP4ZmSxlu+RscoMBChw=;
 b=RIsv5afWSgwaBsHrWV+NkUUXUbcwsEj9dxt/x3LdlZDIWXgjQv29hkzf00r2ZDkMTRnp6IEzvUbBSBXwb4DqAX0qMMLlmHIKOdgsLmRCq/BbZI/DCZ9Ewm6EjyC3uLG1iP7jyb8/vrrczNPFkQ0OXYVtdJ2IWQ08rqCTuThOjNM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7398.namprd04.prod.outlook.com (2603:10b6:510:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 09:06:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 09:06:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] btrfs: zoned: encapsulate inode locking for zoned
 relocation
Thread-Topic: [PATCH v2 1/4] btrfs: zoned: encapsulate inode locking for zoned
 relocation
Thread-Index: AQHX63a/UHRID98xPE2XET06ZFTG+Q==
Date:   Wed, 8 Dec 2021 09:06:14 +0000
Message-ID: <PH0PR04MB7416360B934D51D55BB4818E9B6F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
 <b1d1bab106ddc4456224c0bf1c1bfcfaea4844b7.1638886948.git.johannes.thumshirn@wdc.com>
 <20211207190812.GC28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cc1464f-150a-45eb-322d-08d9ba29fd03
x-ms-traffictypediagnostic: PH0PR04MB7398:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7398DB970CD08ACC91BE93349B6F9@PH0PR04MB7398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvBpJSll5r8tgP47iK7BhgcJUUvcGX5xou9IQTvoGLPQJKDIGnW3C2tqVnPYXqdHGB6jRUdcMUXg5AbkNoxlddR5XFYVL8fN4pph0DeYT0Hp4n95F+0/xR4wHiqrAarrw9rgMUj1nfHrF48eeSV64gxTNMUqQIWSbPdvI/yKweseS/2/XF8HyK26Xw0E3Q//MRE2lRu6GGbZ9PNktF0k8esDqeorzeSBvS/fz9+XWdeQPlvjXFB4VwLb9eqjbzo89521sahDC+zkHZos2ZZQ0XdAfza50haVijN1gMfIYNwgeZzEiM9jnybkYo9CMXUzVLj/lxgaOGB9fcjMhR1kT45xhguJZbSz4U3TbbnGARAfg2810bo1BShF/E+rf1gF09N/uOXeOk2Odl0Bm25oQQbrGufjF7InUytJGtAdHH/bMhY0VEr+7VSnddYPi0oIzgGAVbwT5tnoOrNtP1kYbEtG/hV5oKyl+fef7b5gYw7UTfhQyHyXiY2vgZfIljnoMxhU/NyXDAnavYhmaNGZHyEnP5wjLL+cwYM7zuK/0tMYz55xVdqHN8OLNOZr8hGdOhjLSuOllKCqIr8Fw7VNWWosc7QTxmVtdv1VGIMzUUIjPGxmwkbdGxqNNekaPf7I5KXybqKOYSiTH/uW5cgwO0ySNGAdLaMboUAyxWouE2fGzaSF069O1dUythk0iRcYbkTULXeZ6aUW+46Zo9OQMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(122000001)(316002)(4326008)(38100700002)(508600001)(82960400001)(71200400001)(6916009)(53546011)(38070700005)(186003)(76116006)(9686003)(2906002)(91956017)(52536014)(64756008)(5660300002)(66556008)(66476007)(55016003)(66946007)(33656002)(66446008)(558084003)(86362001)(7696005)(54906003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oK0cIJ+C0bZrfcq9RhopPYP7Lo6GNrcByvi08hX9o1ot0wNV1s2lI7nys2s4?=
 =?us-ascii?Q?u8gC080gTDoTfQF2RBezOdECoaGvd/GTj+LnO8e0SrVP0fEl7P9A9IvmVWeO?=
 =?us-ascii?Q?MbQswyh0cD3I/EPQoAWj6bHZR0wQXD6ngtIVqwtRZDsJBFmMBIQ4CqKObBbG?=
 =?us-ascii?Q?UJR3IX/8dkZCKeAEOHZ1OTpMX1U1gJ4QL11xfWG7jw56v4k3h6BVQVvChJqe?=
 =?us-ascii?Q?U7dNVOjLdmqg+v+2AGHtYljXtnA/8c1UPGeiNd3WSbsZNEuWkFoUdoUGdljy?=
 =?us-ascii?Q?FcUNYxjYKOg6V5llVfwcYV5RLmvHyi58vJS5cASr6MkJJI5B+gfmIy7QhzKl?=
 =?us-ascii?Q?P/a6i7tEyUQKcuhDO8nMPRdOaKPJA3EA08zxoM+ScEvXNjOJUfiL4o/tGH/F?=
 =?us-ascii?Q?3klZ0QRBeEW18o96tWIxWlywkLrM9gUZDH5nRg75bBlVHZL708ab5Wd9+KdH?=
 =?us-ascii?Q?DO/1Bj1qPP7wPaKBqpID2RYcoZ01s7ASWED44QynVoZRk4ClZ/X89ZP7zSV5?=
 =?us-ascii?Q?wTMDll2Qcq46LH/4tiV4aUKgDwceiEukwd4ydCQu8jYSZm4zhsyZ+D7dMGC4?=
 =?us-ascii?Q?Jgh6DJUaKwtfdm8G+VhNW1G2jvw0MO/iiVSEG5K3pyD02e0PuIPW22xDm8H+?=
 =?us-ascii?Q?HHRQGjCmCfN1vAZY7Q5qm5jlWtPGq+xxl+yOJbyIcljC6pQhz1avw27ApM28?=
 =?us-ascii?Q?/Wzur4H3CSXtk2Ji/sRPuJ2At9ywGFd2VuTKOilNdZ2sDjn1wOomRXIaD+5V?=
 =?us-ascii?Q?Fn+LKNTpdXCxbBkffDOUtKXHVoTZ5LhBUPt9jIxHxWFztt100mO10tauOtUr?=
 =?us-ascii?Q?uGf2dC/fPkVIC47Q72CGQg21ScSwX5owdUEhntSMiMSyubLYp1C3N3oUs1MQ?=
 =?us-ascii?Q?RsNm+j4pbdnquNKNeX0vgRAam2VHrH4ZLbXN9WlIRtwmsLU1DoZ0wkuj4JhH?=
 =?us-ascii?Q?kleKr1EWVjOAW5Q7ErEtLuGfxpBHaazsutG/5HsoTt+S2nd87hm3Fj1OXH+I?=
 =?us-ascii?Q?QsB29/kgbojJ4HoZmLs82HodiuRHZJO59gfCw/ARk55wJXTcdpqFfF2/1YY4?=
 =?us-ascii?Q?Yg7U+80SUFg9RFgT/q0TOiNhBAMIeJZRcPrQP+rcXfrg1Icw6YKDKpw7utny?=
 =?us-ascii?Q?kihud0gVlWvB1EXj3UvrqLNUxpLwIY1qgoSAKEOVTNtCZat5SjxIyoie0ak+?=
 =?us-ascii?Q?cJ2/hs035J1EglATJbY9NPt72gy5/7QPUR7B8/gpifIjp+u7zWgBqts6n2pa?=
 =?us-ascii?Q?Vud9lGE/Aotkb3D7agyyCt2eSlKTu2TR/+I5IfZ4xR2VcplsIYxCyFkLem4c?=
 =?us-ascii?Q?+OfA0plZU8BrG+LpHQLmQc7L7jtV9MGchLYJ3Bmgly3kdVypAf8/qP8DvotG?=
 =?us-ascii?Q?EHgwdvFdgWKDWxMDGwlZ4wqo5R/PIW2bEH3zHd5YwIYxvMpNJvFFstmg7xIH?=
 =?us-ascii?Q?fKcOuJAIkENRRz7MEP1Iosk3lSNh4SykVMPcUt8LIK3OjmoqYlj4yUU1L1l3?=
 =?us-ascii?Q?Z3ViLd2C/JyLmhE5Ev/2AX0NlDwNHvqilQei+9Wn1xiOk/fnniJU79mEh/rF?=
 =?us-ascii?Q?VBGhV/vsXXjDNfBHJ2c9rmkJratSbp5a3E4ASDQDIocTQmeTDFAXQcV6DYto?=
 =?us-ascii?Q?ESpfUxVdPmb8enQX9GSntPIH8UI39AX60uouqoOVfJUvgq29fV3aCjlPAdGb?=
 =?us-ascii?Q?aUyzthRnG1k5OW32WmhlANCEaqfYO1ib8R8//98QDQvHBrCimdylP1wfaJv1?=
 =?us-ascii?Q?Vg/r82Br8gDOWPikAyV7EasscdO0Rg8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1464f-150a-45eb-322d-08d9ba29fd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 09:06:14.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMRrlRyB9v3u7d7vcn0EJkNruJ00VD7/ZpwhdtzCW7dFuqSMwe6s6nxL/N/BqwlGimS4b5fsDnHmD3H0Yq3SiTZsg/WJ3oCMW3u8jNKlfJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7398
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/12/2021 20:08, David Sterba wrote:=0A=
> All internal API should use struct btrfs_inode, applied with the=0A=
> following diff:=0A=
=0A=
Ah ok, good to know. I wanted  to have a bit less pointer casing =0A=
with using 'struct inode'. Anyways I don't mind.=0A=
=0A=
Thanks=0A=
