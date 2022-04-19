Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B946D506A44
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351442AbiDSL05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351438AbiDSL0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:26:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E076369F3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650367400; x=1681903400;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hawKroDk6k6eJ6/bJq/IoCgzMEnEcbGa72IhvgvGPJ+6O4e0r019UrmK
   9ebZazjGIPd0RWiKP+KDuMWvIMn09SF+v/7g4owsUcQFwm7bGcl9xXWuv
   n0P4tr++df7MWfa4R8LX7K8hklCctMG6Rlov+z1LEMslsF0wtWuex70gH
   7TbNn1vGWWtXomeCoGpj6B5eDuBsRo0rIhCcWbjj9OT4zGalAAD7NzB/7
   VX8hZtu+EleE2vzDa6Xaq0gPUkT1l5nu7vltVuEQX53CWFbrtFj9aTJnL
   y447X8KKvZSXQ3vLjqFQe/ZOB0sqvlAShtu0P0jc5g7RUkD5FhDosbmcE
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="310226901"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:23:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM83Qe6IuDS71JFNGSVDfgmCBHNvoI+7bD02kmmgAAgr1OSZxGqd/ZmFqnMHSiZNCkrTyue6hZe/6V7PV2HjIFtrvYzHy4Y0fPvAvPJt9ZSeXerbNAsxZ2Ua5W86HLjl/62u/1wUKoTMTeygJ6rz8K/IgQKCzf+LdHcTjRL2rrdgfnLv1MmNONZ9IpU0I1ODkGSbNva+qvg/aFv/6UgqIWCVI5vOJTAjVKFD8wcnfuHIp88nG1PF/avP7vsh6ijR6gmbecuDKNt3maeFpVLiJyy/R8WNptyF5oD+Tly39n3fRfKbFcnZDYtomUtIM6vSvv2WS882U4TPpr/Y7GfeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cuMyWEXwL0YtWSNNvovkUYWU9QlVOC0KLBZXBWCJWBUyvnCsnPLJtk1XF52cIh0SWErkcWA1zPDwFS8SuOjG9v//vRPx4vzZr54TpDL0XI8bnb8xMKKgy77uRebwHKMib43pmSLIEOi0ABwsO0TiYz8UeEvRpvqiZQsGvaiAQjTWZF+enVtQ4hUw3wqxzZKqFdjDOSGdadbf33cJiK1n45N4HDpjl86Da2/3T6o0VTwWYYu6t/dEcLseuPq66/E+pEevMlCE9doD3AfiahB5yq5hvRYiI8Ae+xZ+9QCYL+0v3mSrHTwHtmFFFc+rlssu4aowdQohCu5w76KCwNrTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cJ+HekhWIFil0LZO+6JX5CtDuJQ7HYII1udRVfp2f9lgdYmuHZ3h0MIThW5ZvX/xbzIKsfyJ1Le5Pj+kxTHJg6GxygTfTX6VT4HdRHGetHa/JTNzDrSFDrtJQxXDo3fq5m+mpA/ZVRapR2xVkLNQrmATqvXpZ7zkF8vJ5Gd31jU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4914.namprd04.prod.outlook.com (2603:10b6:208:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 11:23:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 11:23:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs-progs: fix a memory leak when starting a
 transaction on fs with error
Thread-Topic: [PATCH v2 1/2] btrfs-progs: fix a memory leak when starting a
 transaction on fs with error
Thread-Index: AQHYU99QyMzZvyeBr02DeUXzPxpapA==
Date:   Tue, 19 Apr 2022 11:23:15 +0000
Message-ID: <PH0PR04MB74169E4631722C4BC49D565F9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1650366929.git.wqu@suse.com>
 <eb2a7f4ffaead80af30e12c43e8ad3989d7fa83f.1650366929.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51be805e-a2a1-4d3a-2e93-08da21f6ff2c
x-ms-traffictypediagnostic: BL0PR04MB4914:EE_
x-microsoft-antispam-prvs: <BL0PR04MB49147B65985D9207F02CFE019BF29@BL0PR04MB4914.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzTL5PzC/s2d7+kg7KmvxVCF1RdZOGnSTmZcwY5eyLc3so971VVpFYwbRNNF/3z9n3uV+Xl3NQZ0tuepGPytGjVTgzK4B++/uDNTClcwxmdOwU3yCqCJQRFZJTTh4B5N0VSbgX78HRPHtCAz4RlrcxBB1mZrPKOV5YKA9EnOG9khG01Yn0nCD4WGJoq4U6AoIojegHB8Ep14bIq2D7FjAng62++9oZfdX7IGlwsxuIiF9HAh6RqGdxflS3pmR3x7Cd3SJK6HymISLeuhCfYaYRL1GeJ+cjbCYX/CVTn4irIpIfUfYLN4W0JQDScpYnBIvyz149QRUV5wZa+q+ft2O8XJon1ccqV75VOYJl1dyMIe9Aa/ca/XJyEy2ce2hKZVxGcSBHJgJPoWbG1Pys5cNHAyi5twkl098Op2a5KDnKUXsrPxOmrwdp5sZFeu6mfY9Zp6zWgDKQSj61JaGdZ9+I/cZUDhwmxHhkmdCQ/gURfqIs4RdD6Cpflp+2fEm+pN2/cG42/QNw7F30HIDQmx6SGuM27m5eVyHmRh2p6ffvr3dpCczu5zuh7GlP/QkD/2eBEUnsFOuSdElRFJDtcoeRZKmUQl93rAu2VKkiCNp6xJB0FHEGSkdhQS8plHTNbgXjeM1rs4wU/myrYBgqTf4uEz8Njw8Ohf3yunrUEc298Od7x2LJj74MzPtgzQfraG7uA2MQ5Q0HPpe9+BMjE6eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(186003)(38070700005)(122000001)(38100700002)(71200400001)(6506007)(82960400001)(52536014)(316002)(4270600006)(33656002)(7696005)(66476007)(66446008)(91956017)(8676002)(8936002)(66556008)(76116006)(64756008)(66946007)(55016003)(86362001)(558084003)(110136005)(5660300002)(508600001)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bwt4kHWjfxkv8kKCdPcQESo1pR+ArRea/RAuTFVGdiMZCkbuQLzHGV9a1YGq?=
 =?us-ascii?Q?+EOAowGIBsFpAV5hm9oUFNipLG6IH1eVfkKw2pvczU0CkA+j2wj6EHUJ1cFI?=
 =?us-ascii?Q?vcx67Hc5jQEuzerIVRTlSpMrmFewJXZtH3XjrVnMm/gEeOQfLIQPmujolx91?=
 =?us-ascii?Q?Pi3odg/rQIm+NkGFni1uXcV5mjTTrOcZix1u8mOvW0rgMkmVaMRUypzf53jo?=
 =?us-ascii?Q?TXewPhzRqKrXjCsH2VEX3hEUPsCUtJsQo7SDBOhOoXPnEyUX3QJB9iWf56PA?=
 =?us-ascii?Q?/iMLmGvoTFf6Q0QqqZqTIgTj8nKbkJ0JNptPWMIXzqYh1ZyZYN3vFJgfVwMv?=
 =?us-ascii?Q?MRmdr1i9nUgL828fW2NwmfKVn/1xzplYWjcVZtYyw90klvSJQmiLlhI92mdV?=
 =?us-ascii?Q?C/o7/QCOt03H3/7sFV7kI6jo8p1OUjgMYYuzyqdw8jyOH9hHLLTFSn+5k7Yf?=
 =?us-ascii?Q?rrk/KiXcNPyynumVPMYfAgDYrTpyVwjm0VC8zSWVsMkqCGMjrHeUkh3RtwEw?=
 =?us-ascii?Q?5nNlDTPMmF6NjfrpxbDCcnv3q7ty9Ping/ynBpLIPPuzZusG2Qd3o4wL9qjn?=
 =?us-ascii?Q?Yz/NLWONCRISFkYUxxBklvX8B2wPiMKcsvH4X93V3rDlRE72jlGAZEX+Oy/y?=
 =?us-ascii?Q?6p9YPAw5btTJNkwE9AF4cCULe5X29JF021VJAi0PrbNsKPZmDNTeRW5DYkQ+?=
 =?us-ascii?Q?doewbMDhZWxUgGUsaffzajSZ69QzLZ2HiNlhV9TKAmks2CfwuRU/qLpRHQLc?=
 =?us-ascii?Q?B4kXJlTM215R4uyu4o8gv+Mly8SNOT3AUiL+OBXSHr96ATBjwpYn9ozlTdNF?=
 =?us-ascii?Q?OkCOdcqysz07F8UZ5EHLZnKMQiaQf5mMWMFIOwIA7uqjF+2vcRVZZOY/fsOz?=
 =?us-ascii?Q?n/cMqLAXC5mlFUA3n9B5mtbfAWZ0Tm8Oyz1rj/e5snFIANWbLfcwm4nVm1c1?=
 =?us-ascii?Q?5DBKRRYhyf+ZXtZx9aLANvgUdyevIMjBrkEwGZktytpBDZJXUEhtQnrY3atO?=
 =?us-ascii?Q?800wBxaFiJSiuf5r4fczQ1zTxnRkpIk6uFhLx9QHJUiItlGRpfWCzU3ZWMx6?=
 =?us-ascii?Q?vz5W+RWVGSDV6IBVyvJFiwKQNExRFoGHGrhRgExaiZVL5TJbfNFbiQp44tOH?=
 =?us-ascii?Q?h53hoFRGQLXYz8drcyR3RSP9Dp1ITLsdpLSJz9l15Nt00MwhaYq4YJmc5luC?=
 =?us-ascii?Q?IjI8/m5Z1Vm6lPSJTuszw2l3V5yPfhd2uPJaQNBIIZnub6bbws3r0p+qes4F?=
 =?us-ascii?Q?g8quaMr2WbXy+MpTD8Ef8fxSdX6iSDYnmt9zczZxJcLrEh84am55ME/Vfivo?=
 =?us-ascii?Q?hwrxJs+pgJIF+hlYySFkUa/j5tsPTrJCbhPyG39ILDkfYMM8l8LdRkTZ9/ZT?=
 =?us-ascii?Q?37XtEu/z9D5ckZyzMZQr9CFG07OR9+qpTFvpADX+TSRe7RiZ74OEpzroIvJa?=
 =?us-ascii?Q?zUxtOij6FSuejQxysfZpTX2/F77ajlR4xNMqBXp+yPDl7YmeyD+9HwQxfGdP?=
 =?us-ascii?Q?UuKL5yB9HRuH6O2Z93YzlN8okpqM5FR54vnarMvq3gDDxXJBoyIyWEagUgD1?=
 =?us-ascii?Q?D+L2mkbeWlBkgvfPAF8GfQVhlMJx+Xt1dT++bNOTeWSZERljDbj53dJ6OI7D?=
 =?us-ascii?Q?1fS5fuIQOp/e9UCyEFeRCMfMyYiOICXADfW1MH5mwsb0o3QfEPl7HtexJrdY?=
 =?us-ascii?Q?z/Egv2d2yG7h00zgNwDp5jve7rlBXeFcFTe1NxhwsshgU1H+H6DvsIDtP45a?=
 =?us-ascii?Q?18J+ta7nd75f9SDVPb8LNuFkzBgwwVwNyq90KSAndQwgOhuU4xDNvVuT16N1?=
x-ms-exchange-antispam-messagedata-1: dPzf40M0o6B/Q0U5Et2Ks3S5Xhfu6RlOWUc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be805e-a2a1-4d3a-2e93-08da21f6ff2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 11:23:15.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQmd7ImLJQaSnqA5nhJO2vAPcdeEcpFWETSrLh73l7usZNjI0S83Aig1NvDb70aMm3Sd94plAMEW4V58Ltg+Md2wXi7BiI/tNa1p0/XRU/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4914
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
