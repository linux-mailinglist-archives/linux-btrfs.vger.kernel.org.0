Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77DC4027EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbhIGLhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:37:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46813 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbhIGLhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631014576; x=1662550576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5KMMcIfXV4KX62fakC17lgUyiCK8U2pgK109Keu9xag=;
  b=bjCypTmQWDZQ4q6ofoShDak0khsH+SrnC3GBK+rwQRH5BdfvZRDw/eEf
   noCEdigEhVIUgrJFO84bir6X8Au6jz4nin8xCO0H8qMlhxNOEdvcIcNzD
   HC3OWBqTMMUkWFbvD1gmJ2EfuuIDoq6kbnUOrSV1JrsUf58vSFZDxIbg+
   fs+Wwnjr+zEizL0TBtHe2+lF2ij79c2vhWQszvu+aL3GPS+RqK423oybP
   5bKp5maxNQr0gnru+gO7Yz+Y2Rxo7hPUemPiptbATOX9ivfBJG3X6zjPT
   1puvnqxgr4rvaVKbpWc4SbjWk0RrEPKcIb/D7DrLgAuGkz8bAbhKgF3jp
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="178465002"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 19:36:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB2fU5XOral+RF2ICFh5hyzLNu1/cADSrInXmm+BadaQOG6pQAA0NvNSjUdhRHAwLvbPQch+ye8uzdifuyXWYi3kS9CaNw3UKwCzeKo7on+Qa6rQL53pmgJYWiqnhQmCPSrVSodRaaWWYyIHjtHGGZHZ6RF6nn2H1sX4bD0gT2h94RyUDWPbLyng3BRfT/tL4kfmBbmCKhqiO6OSsXGZlXMawNWZPEjt4ueSeAb+E6uyAc4ieiFlenjHmADwH/9PEUufcSht20Ygn5h+604VipX5lFAcpGypsCpwk2Ea9Hhs2la78vpTcYJ/sY7pbrfu1ai3NBO35GBNiuab/+Au0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5KMMcIfXV4KX62fakC17lgUyiCK8U2pgK109Keu9xag=;
 b=bICgPbmnLAZzeQwKnS3hjTMw54/QZrlmwd/BvZuVPhTdNHO+4SXEmgXR2PdPzUzSscpApUX8EH5DbbxaPt7JMzY5LNbyncg3ePobL+Gnnk7iyb9puZbzjwbuh/XSsKv0XOtRu7SQD1GEUpvz+OBKBps5EgOw5HY2OOah22JVgARQ+oRMMEVEWlFBB732GONVaMf1fZuzWt8m1R2/OVkKXLdz8XrxWWVGI/TWkhKeR+erHzH/r6y5CRda3YqGT7JXV/JsbHRkAjdb3DJo2pMTvmiHhBifgMyII+ASt5U5HFENps5c4bT3erYSGhv8AEAJQSatnkR2yDAgizyyjm5NCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KMMcIfXV4KX62fakC17lgUyiCK8U2pgK109Keu9xag=;
 b=jykytn5fmg48lSTkh13NvAWD/K5oF8TByEQv0TVLounyr1iWkggTl80THbFFR4BqqFMqIyKaM2j/auP+SEiBHtRa5Sjow2HPdcnagQRdXY5XDgvirYWbnRqcyZwfBpQitGjkapxR9azMjWWMeJ0UckBTLWsbJeVW4Upw9FTBHl0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8276.namprd04.prod.outlook.com (2603:10b6:a03:3f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 11:36:12 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 11:36:12 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/6] btrfs: introduce btrfs_is_data_reloc_root
Thread-Topic: [PATCH 1/6] btrfs: introduce btrfs_is_data_reloc_root
Thread-Index: AQHXoNJMupbb8gguuEC1It+nE+TIRKuYd3cA
Date:   Tue, 7 Sep 2021 11:36:11 +0000
Message-ID: <20210907113610.c6usltwdi2cdttu7@naota-xeon>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <9f8e2c5add21ca257c7b5df8e86c87c2de9b672e.1630679569.git.johannes.thumshirn@wdc.com>
In-Reply-To: <9f8e2c5add21ca257c7b5df8e86c87c2de9b672e.1630679569.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e20ea12-7087-4256-3bcc-08d971f3b1a8
x-ms-traffictypediagnostic: SJ0PR04MB8276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB827610954D39CB4511C7962D8CD39@SJ0PR04MB8276.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ioAHkWQtztmjxqpeaeLkXtMOrgeij2Aw0sP79QkbBzffR+Y8p9OcRdFFCNvHRfAkhhL62zxzjCgMadzug2eJ8G+ML305UlSNej9KEgJ1/TI0Nnx6AZm+xZkhnEsxgXULyOP3VpeM5k/QH5KLUzrZMlU/tbCke3+rAdZef4Kcnd+bv1bozjIb4ldUopr+z4vf/xx7/AIgS8G4umNcN7bxh1X30Ko0/sYVYhPPB2I1zQDxGqu5LpDvfLam+Bvk7N81Sli2s003oPA6NRRwzpxqA2GPhFYjQP6jyx/DYoPwRcZd/M7KbppwCgsITKpTpQfTrJkQIZO9j7GfjfaY4OEv9kSwQRu8j/QzxAJuObH/j8xUvUi9CKn25NWA2bRV5V34NHLq3QkCNOuE0nxylDNSRT3dotoV0Tva2pyw34YmI2snAHg43m6uCFzLRQxFXvIQGFMTKc5YHcEm/dM3JV0L9433s4LhVyCl8cGkZcAwBZ0ZkoGS9pqGpi9iNOez1hnYsXIBnjx51w/FnlWdu/OQLTa4h5/mjIWsJdonlwnE49ssthvHGYwfizRwLpHNx2NMj2KJsaKIO0Iuo8dOPDSpBgLTHEDzfxW9Bw6+YvYKi0RzqNq+QbEH7CjwyKHtH0mhChyfWxaHPgCq6qs7Fg7m4Vve4/y1oaMOUR3f0jlyhG6tlvP4sAWcu+0+2cteM2bx9GOoR6srdssesL+XzUE/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(6636002)(316002)(1076003)(478600001)(26005)(4326008)(38070700005)(6862004)(2906002)(186003)(71200400001)(5660300002)(66946007)(6506007)(91956017)(8676002)(8936002)(6486002)(66476007)(66556008)(64756008)(4744005)(6512007)(9686003)(122000001)(86362001)(66446008)(33716001)(76116006)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QZpHuB6LCIVBILg9NJ8mB/N36w7iyvB4wYOQRVc87nU2YuX8PV3q1FbQBF7Z?=
 =?us-ascii?Q?EwrVovKuTrWW0waCx9/mXwSIK/NhVHFf/kHQKKDTjIgaW/Kp1RXmRmLqkphS?=
 =?us-ascii?Q?tQv0BvwcVFfCZPu3nkpZH6qHonSF0+QRtHRXikIOLLHYed6xw50jJN8ZbWi5?=
 =?us-ascii?Q?/audk5wEszDGHHhyBzhPQoSiul1fMIu8tllZ4n4tEi85NRHjnzyeK2SWRq2u?=
 =?us-ascii?Q?b2RJJmBSjIyINSgfZW2mM4iBptKdQMzdBZMRBHBPNvwtFFE4zzy9jQYwRnH4?=
 =?us-ascii?Q?Giy7uSDBWqGAeWF7DivgUhK40jsYrpSR7HCBvbbSH1ZVYldvWTbqplPzWy8i?=
 =?us-ascii?Q?uOBZlXxIZjTQN7JO7YPKBnN2aisc+8GMs7oPdyH3+qgdqrEyKGsakVEvN/SI?=
 =?us-ascii?Q?7JVO58ej9W3JnktgjNFUbSxnjWxrToFPY/D7IQ6BrFZidh8K+BzZjJc04rF0?=
 =?us-ascii?Q?Jhf1rl+m3Ep/udltxZ0AbgQ53CRxt7CMFo1eF7o0MiLgsdjBZ0S6QfeEtBME?=
 =?us-ascii?Q?tW6g2RKRjKCYAiDb9oFcRgo5hXVLJO9zX9Bbkp+0KnNwHrgS75/qh5Jl4YTq?=
 =?us-ascii?Q?RFZx01VKRg3PqWzkfdTJ8ceE9t5c8sEJ2+n2NjDZbn6ThX7fZ1lCurpoNb8i?=
 =?us-ascii?Q?OShbOtU0nKeQ0AzxhNLJgddX4MPrlTF47AGK7zbSyYwNavtPBvmINnom667i?=
 =?us-ascii?Q?u1BEXvCOSZd4MrhUKUneU8dfitI5z4JcNz9WmrAdB0wZ0pxjbaMg9TpPbLbF?=
 =?us-ascii?Q?wka0RDvtSKsDP6WsIRD4Ohc/HGMb+rHphoHF2oLiJ04HS46+HlWh0MzOgMrf?=
 =?us-ascii?Q?QRGxOnbgPgSLnd48ZJD5zHAXtgXfA8QWUh/gPOhtYJWtW43ZWB2iwUJCP4XB?=
 =?us-ascii?Q?HmSbzGkmK0SzpKS8Kr9n6IWFQT52SXMGYaxe6/CNaRFLqP5sYdEYqACwNcm/?=
 =?us-ascii?Q?MRrGkEK2uwAXbeLGHjNaqeQ2ieO50dS19iGgpqprT424MN9b5Oq+jCRDX2a6?=
 =?us-ascii?Q?o9/YYKacQ0wUEd/vvvI3yaVlxgLbQ1pYd0SImU9V9DQFoS2hx7tLR4+9HPUp?=
 =?us-ascii?Q?IoIAUYUDGFH93t7RvuPVJ+qj9uLOMpmIuzj6/6uS5YN7V4wdJj2XodzqnSeR?=
 =?us-ascii?Q?AM9EXAJgf2tUzs3BxfcrraTX/PvS5EZReY+lgn0cVb7YpVgEkb41Ok0w1U7K?=
 =?us-ascii?Q?WFonomV9HiqOhXLrsirgst9zQMLxxe1L15SaBrfei3Cjp/RGyDZ+K5HHHMip?=
 =?us-ascii?Q?JkKJoNyGh7Fq6EeosS+nl66vLJoTh5x4Jazs0ap8RKL3okLPQMUU2CRyRYDo?=
 =?us-ascii?Q?msBcKFjDOZFKs2eoHpjmEqiDMPBRTuzDGS4JhN+RzmkIpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E524092E37700A4CB1F8423E87EE9D6E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e20ea12-7087-4256-3bcc-08d971f3b1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 11:36:11.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taRYeL51Q6IalHykzQTT6Kt63wuoHe0snEg11HmC/oJQiOuK4Db8zOBTTyVym2j0sZGYkHLyz/YzNKRwNRpWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8276
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:42PM +0900, Johannes Thumshirn wrote:
> There are several places in our codebase where we check if a root is the
> root of the data reloc tree and subsequent patches will introduce more.
>=20
> Factor out the check into a small helper function instead of open coding
> it multiple times.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
