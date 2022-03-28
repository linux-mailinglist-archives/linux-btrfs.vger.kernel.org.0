Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC44E8FCD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiC1IMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiC1IMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 04:12:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CA532F7;
        Mon, 28 Mar 2022 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648455036; x=1679991036;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BTc6bQ4ZPDn/TnXzyVLIKUcBkMNpr0sc7B4ouhkbiUI=;
  b=fINxANZStNIBT7JS/NTNxUi0xrJIEJkKNZtKcBCe1KwRgeCPwEigHnn9
   Dd0+kGtnVIDKOBrf/Ll2KB7JiSBNNOCVv0M9dAub0pNRqcetR9fZhpr3G
   pGiov8lp1lNgZ4cfL8V18WWO8yiYqJH5AoXxcNstbPUf9nLrOkyx1ON6n
   vbeRX8tlVBSkF0TnHaZbdWABhv5ib6KO9lb103v+vulo4aKJnRtADAaX2
   wd96Xt2+Zp7sMeYP16MPuWgUIU1vXktuWeiNpskM7QFYGTdpzHj9SVEId
   0NGLCa/dD0GC9aPKiztbZMLopRzmqnxhMqg1WkSiuFSxIBMaItw0VfVdT
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="201271579"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 16:10:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6MnzQ4/vseGDawlCtyaR0IaNmlog0JnRg96ufCD/MvfLVio/40czQEQDH+BuO3QJMqoqdW/sbDMAaiu9QBwhA0Sd601tQ3a0ZkzYVzslQohjEg8RReqMM6spXWfwZ/RWF5MkWtflntvB4Z/NJUFSX+F3Pr1L01wSH1vTvrGDkAoBS7QU8Z7SJmERxHlCKohWapRZ2Gp8E37rQjBJV4dzog13Lpo9ME5O2N/Q6YvWylOA09MTId5njX8fUJ+El/KZdV3cpAo2HQ/uq9XOwDfUfHX6MoIZj7nWVPJm/KbGC1zaBwiUMweoKyG7mcsA8ozQmejw8NUAoDgOaU2sYMgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTc6bQ4ZPDn/TnXzyVLIKUcBkMNpr0sc7B4ouhkbiUI=;
 b=AQSEYVwF7XyDtIUwrq80dNy2APdEvztdKRmDh8WEU2em0tJS5gRCtIKhkpKr8b0IM//IEbipZxo0j+N0r/6FE6tbvDF2k8TZ1B36KyfDmY7M0x4oHw9rHmDjP53NngfxSEPnM+wxOM+PGafYPYR7uO+g0ITfx7JiqN6pL6brj8KzBuXomxS60nHJ7avc/0Gjejrq8r0PW74ONlGk6tV8r/MMeA437qhM6QzqhkWo4LDj4S9+x1QjGpye5B/YgLrzEkpj+orzNwkllgiWiFYncStyFum/vBGMgqFSTzkCZ1LCfe1p2KzzBgBy5PqFNfTgj2NMIyoaWPgKlnwpdAOoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTc6bQ4ZPDn/TnXzyVLIKUcBkMNpr0sc7B4ouhkbiUI=;
 b=AcOif9QM7gXyEVnBNKo/bidBI5LSgWRHXQLBTARooRKsiXhTr5MH0u/BjvkruM0oFZvFRcQrT/OiZhSbnT0hKD9xC1S1bc/MuIcyVAp8/7V70fqH3BqRLGLYk+tU2ZcA0/4BrJMJpRQk5NqN/2KLww4uH5ZqZi4OUmdAhwOuWCM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6925.namprd04.prod.outlook.com (2603:10b6:208:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 08:10:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:10:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low
Thread-Topic: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low
Thread-Index: AQHYQXpxK3WHKNz650O6cx9MsKQXWA==
Date:   Mon, 28 Mar 2022 08:10:35 +0000
Message-ID: <PH0PR04MB7416A2426687A7A4803628729B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <322c0884-38fe-a295-0aff-caee1308833d@gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17883025-ef5a-4301-96d3-08da10927004
x-ms-traffictypediagnostic: MN2PR04MB6925:EE_
x-microsoft-antispam-prvs: <MN2PR04MB692507D837AD1C31F293AD349B1D9@MN2PR04MB6925.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSL4UqK8WciJrz8fMCQ5PbZhJk3nXi8kYmqt89DP0AXRznQ6T0TPwkiY98M4ndmWzJulIHGfRKanpG+SWjDfobf+runm68fkDAyS2tVOapohYMqh9pzfRQqiSnQFzhT6XX7zQEsvrzMd9RQ+0OIN3twTvZ+yMGHe0+ipgJjDXSUSvuFBEEn05+Qc3itAYeQ+W/WRpDtR7XXHKqYhMQv91f35Z+Vb+XfUURooumN5oSUnePJaJiCMoj3vVI4hr2N3aRTViNfN7xlacz+32q4VNmkkbnkyADRQfXVsNPLGygG2Qklt9NNcMkP8FXXkDq25FhMfZrYKe53Uf3KwS78qaBF4QZJH5Q/Pg+dJJayMHkTJtY9QJFXsIMImERTddsfaMlEAHE0mXuOJY2Bsi0zyjUsfKACI3t6r9yB/Ss7MbS0nkduyxlA1hajTfS0s1Z9tLN9DRK5lXa3xSLAIjIW/SonT1x4xNdJEJw4upCeNboCwZ1m7xtF23JofFlvwgxy9Agg6X8IF/rjSfF1JNURO9wV8aZ/YdUHtfd9/X/FSBB9E2OzKONn/enYa6yEdZAdwyol8WbIla7OqA73tH/zjDP3AvUCPmI5RebussJ0QoR1vxnE/LcSIMj/wbR6aY+BsP/Sram734ik+7kqHgjHsFfzumMDXpOpNv7SrbwI2Ey2rXQxcpBh9ygsEDUAT+PyB6K0/ziQ1M43wbGh62YeBww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(110136005)(8676002)(71200400001)(508600001)(5660300002)(54906003)(91956017)(4744005)(64756008)(66476007)(66946007)(76116006)(316002)(66556008)(66446008)(4326008)(186003)(8936002)(86362001)(2906002)(9686003)(6506007)(82960400001)(38070700005)(52536014)(7696005)(53546011)(122000001)(38100700002)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+FEQX6zPT1TnbAtqNYCaqdhi9MgEPVP4y+pAxPVykvuhOk3mXKi5vhpTg029?=
 =?us-ascii?Q?29aLneApInu4Kw6IpQ10qsDf+X4ixWXkWshjUPRYkuldgcpDLb/HlAzVqhpk?=
 =?us-ascii?Q?mBcDjHQ4j5DpTEmsRYwYeKs1vV+vZaCDgAzz3IwySFWxeH1dzc6OWypXXpHi?=
 =?us-ascii?Q?zxtVPSdEElmGHmiM+P9nu/KNJ2NP6q/vTvquYhCZ65K78Kce1J5Gf+HvfulX?=
 =?us-ascii?Q?4VnugloNPVoJmnIyV+u8ZOMF1LBSnVMnpcwszYtqtfRw4oPklE+i9wvks/7I?=
 =?us-ascii?Q?U0alQTEv2wGIy8mB9UVB6+2cKlEajvKyM4fjRkVqKH7849SY15XIit55JrgF?=
 =?us-ascii?Q?3LD0asw9n/tVgPSed+7f1+PpGvkaeGu5OpWhl23nc8/52BP+KNt3tVZwyzYS?=
 =?us-ascii?Q?9Xlo36kQZlICtIX4shGrv2engE6q4nd3UXU9Ivc3qIfccj3UCBIhL4IV82Ep?=
 =?us-ascii?Q?7rpRlMIcpvn0UVe/bCEfnQI1eqRYO0ClMSuNNSxwh0mZ7CU+2UmiBnTyThJQ?=
 =?us-ascii?Q?RcA01n3tHOp9ngv4M2adqgph8cRxxSddIO2nfiEnZwcemLLUwbBJdP1ZW6Gp?=
 =?us-ascii?Q?cQV+UlleLFAW1IkDpYjDrhzUm2/8+fN/yjuvn/R+aFD9xBQktF0XrwB9TOLb?=
 =?us-ascii?Q?gCEXVrqsqIXoHZxdlgNexFJN9YQ2IW/3V9mz/NCxUhfQXMSxZ+/vifUDWMYk?=
 =?us-ascii?Q?kJCyRnmxxtscwjfVqtGlBNFKE6blebp0LB/vhq4HCIXViZWMvL3hQaEYMDxi?=
 =?us-ascii?Q?L+UUcoF0FDYaKuT3M8QqwAGOfWUUtUUrc+CfPsDXt+N6u7lV1AV2eqByK59Z?=
 =?us-ascii?Q?f9nEKXUMJjn5zNQ13XtSIMzJ/FGzQzp9/si7at8RmUysyonMKE0/h+GDnp02?=
 =?us-ascii?Q?4uKN6JGNGN9HHKOuhGKeMXRMGNn0ttXmBPwCxf5NN2PGPR+L7I2lyuW7ubBK?=
 =?us-ascii?Q?MKR51/iDImSs4oJgPj/sLu1WmaJtEMI6iJRs4mU5q+Z385xehxBLN2jdHLFb?=
 =?us-ascii?Q?LUpWr6G14sOs2ZkJcSOHeVbDeFLb6l2aGEUmuEzRwCSnXXaUews6edZWCnpd?=
 =?us-ascii?Q?bjZ4j2J3FddtaCGm0/mdyfka+N7OBs8clepXgTmZmfDKBrHn47L2BrqOxoYK?=
 =?us-ascii?Q?lWEuzp3h7Uz4+q0DBg7kdkwEzFvu4P6hCnytetDRfWvjjFY3Z2QVj6bMgwk5?=
 =?us-ascii?Q?7bucicAqW+ihNaAlQvPL1N4trh9zu1PyY73nSXGjBxZdSC3GWHaQrTMaE5YJ?=
 =?us-ascii?Q?C4XPbnvqNVK3v19R7UwI8+JzYS1+uWednbQKlVc1R6CtZxkaACvTgEpx+PgS?=
 =?us-ascii?Q?6QGDOH5cGAZJ3jkaM+kHmjWdp5SON8GqckJTrM+/YB15znORDnA1VSAdea/y?=
 =?us-ascii?Q?4+GdaZmUWiVyB6MB/BWl6QlheH0Jyqy508O5od99cJPQupciHrAP8UcYqxUH?=
 =?us-ascii?Q?8Kfct/8XMC71BLzq6YrBpFtv5Tf6kDumyyg+4KCxRXB9TeKd5VqFHf5czguD?=
 =?us-ascii?Q?suEOlNSgn3rO+SkWaKIV2x2+ZLQV6nJkcUPsQq0UxroaveIG2KGanidkkk6Z?=
 =?us-ascii?Q?Ff2fz6GY9+N+uT/BOViJyQWDO6QCMCwzhmLAm/qsUM6ce36/ge5jqj1kLyOZ?=
 =?us-ascii?Q?yrVcttmCTwXBigF3qzjHPBboVhpP92T7SEVmN9mk6S+mniNDV/V0hwpNCt64?=
 =?us-ascii?Q?rfOOpTrd4gsVE2vDOxpECp3ViL29p02iMMBSBmeKfGucDbfAVqh8q7uVQAD6?=
 =?us-ascii?Q?cfCnF/Qxxe/lEJHn9/O8p9nU1V7Ppd7xKbsW+/ce6cG0HGII2+APCLWev415?=
x-ms-exchange-antispam-messagedata-1: qm3N8MDlfgEYDHhfkofuixnB5/u4armtGd3wSUTHmYt87m59s6W1jVGv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17883025-ef5a-4301-96d3-08da10927004
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:10:35.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOQpWcP8Yx3TtC6dJtvrU9gx4MkVeql+sLcdTS3ReOj49LOhkr9ir7FOQ2XFoPXtB8ZniEiAHIQhaG8Y0nfj+us90mO49+TB6rzFoXexRUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6925
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/03/2022 03:31, Ammar Faizi wrote:=0A=
> =0A=
> Hello btrfs maintainers,=0A=
> =0A=
> I got the following bug in Linux 5.17.0 stable. I don't have the=0A=
> reproducer for this. I will send any update if I find something=0A=
> relevant. If anyone has any suggestion on how to debug this further,=0A=
> or wants me to test a patch after it gets a reliable reproducer,=0A=
> or something, please let me know. I will try it on my machine.=0A=
> =0A=
> If you need me to send something to investigate this, please let=0A=
> me know.=0A=
> =0A=
=0A=
This can be solved by increasing CONFIG_LOCKDEP_CHAINS_BITS.=0A=
