Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9814D5CAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiCKHtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiCKHtm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:49:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBF2AE2E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984918; x=1678520918;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KG4TTVAWiKa01A1vlC6KLdT5o7T87Toej71d9SA2/pFM9NXq7cdtyZgb
   W9HLXcpb7cB19hVmHVSjA6CoDsRfNsKyYKGnGr91+8kVZKnKyWnWQPE1A
   mqSE588byu7mpmpvucI8kK/q0MEPpV4Z9Wuvh/snYtsjXjwul9rtfYYvM
   oHn2QzQvfWKnvH4+ASVa73S455UTzON8LxP/B8opM0cN6qYqqqQVwlps6
   ++MbuxjTBB7Qrpn7ZvkbMM5EDrZJ9upeusz7QJxj7aZ5Uwrdv5paIy3G6
   GZ5Gk+jaGPSkQzca6810/zzeZ5AN/HULHa5uKKkVvQ66m0mPWMHHAR0CJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="195058227"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:48:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYSut7Hno0YF3ZgoE2wWmCCpaIYUTQ4F5ywso8cUglXceTMPSpvr9R7AQFkQgDIhqhp79PklgwE5BOiaM0IEv8ZKv0NHv1gc+KxsTGrkCuzC6KfetdXj5OSxwFOlwpPH41YYHvnx/6hkvKZjE0ionbr3lzMWafsffFN4xem8q2zlC9LNfMnkiRxevVgwPYz65PrD9MTq28+XqYFDWN5Wtq8QqAMP2La+FUXKuVbUosL4APvvGRolvKRQ+kLgVDFP746cA5VXZMZfIAHo5I+tcorgWU+MHWluBa9hPQqfqImx7vrC/cv/n2940FyirBkyFsG6+xslHbuqdEMvHvavnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=g+5AVEFRu3YRQts4Mo5TO9OgxJvevxBORjoloA4VB22NyYdrHpOeF+uZ24ECaSzABxUz5GS5iQQP8jm3bLJL15Il8H8nDNWUpVXFsI13XsFBssmur9L4wpIIPDlG+h8f98RSh4NBhvTIAvVqP3sFUBu1urQ1zfiiAtccQPs6IRBNWphpedmPJvKLrT28qfv4ZqHAchh2jN4xNTTX8VI8DfjVh7DfSkpvPuPh40vlZcE6d2hHnm4FQ8fZSoCC3RUpgiZFf0qjeZXb0O2hxkm2ViUnyit3uVVi6x9cHfUzVwXvaQczibYwS0AbLpllq8alWhkp1S9eXI6vOy3pp/yWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VEjPSto+RxkSe5psq/3dUAoqsDeeK4eT9uCECLuAnX6qL8jlCQ0d2Vk2gZqKkeJBCJQ5636ihRc6rtU9QC5RdpHz2Dh0/putfrvLH9dnDV3HXXjSxOBX+zZNp4lnjL+jcWBqGSP89LEUNha2PzD5GaQ3RWQt2o2ihXTRMWKxuWo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6982.namprd04.prod.outlook.com (2603:10b6:610:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 07:48:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:48:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] btrfs: allow block group background reclaim for
 !zoned fs'es
Thread-Topic: [PATCH 2/3] btrfs: allow block group background reclaim for
 !zoned fs'es
Thread-Index: AQHYNKh5oDB7ZXfot0qm97NXxeX8TA==
Date:   Fri, 11 Mar 2022 07:48:38 +0000
Message-ID: <PH0PR04MB741626484632A3CDC575AFF09B0C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
 <ad985b39b7652ae2ad85ecc51eacbfdb5045e1b6.1646934721.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61a12966-2a4e-427d-428f-08da03338db8
x-ms-traffictypediagnostic: CH2PR04MB6982:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6982DAB50E56158C66FC41B99B0C9@CH2PR04MB6982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s85WSc5oyo5h8Zm50L7KD/NA+e078vZEkshbDrrQl/6vcMG+TEDtOZZ0qnM/joo1tWDRu5hYmf9XkasqNJVTxzXYHWg9kD5ghwl+rl7t7cm7CC/DKlHyKuN3szc4pvIuY0LDqS+nwWjM2R4NrzWRAbugag/MzSc8DDKQ2dL4MWQb5b2Yke18xn9IYjSG7ZZgaWEwS6YNOrPMXOgic1adtaNduTkR7Nuasfq/nlEUwUYDy5BVpV5C/Kwp1dZ2rTN2TAtEJTqP62MtvOv2VF8dEQFS0myxjODUmOXU3TS9NMr8bDq0oFiZlN8runvrHs4HkAEStWYI/NeaGNfhEQodrS1jiXM0qzTxKleiS94XPpNGmYQBvcPVAif+3fR4nhOrhR1WRDDp4yZv88Yt3iawKSLyCTRoQVzhBO9kjxDH0TGbWgz0XfdFIF8j1pULEa1a7WCL1hnRek54CT0dUtGTEI17mKW2wBte2oqd0RoSdhobpsVl+uMPz6ajAfdmwENazgPr0Y4ib5sm4YiKnIAUM84jJMmndDo6WazrnHw7p1Xz82IwP8rLM/IPE8uhoEmMkeDL22ymZ3H8mFlAO9nn6m0obFxU2bKUrhsbjoYeXWYQkghUgBaAecSSvRE316t3QK6yryJHeagkCW5ly4SYRs6ugu5U74miQhPgV6MqAEK8vdZFjF2qS01xh5DBY4h9kFRo7a9t/Z6uEsD53wbT0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(64756008)(66476007)(76116006)(66556008)(66946007)(66446008)(8676002)(91956017)(52536014)(19618925003)(122000001)(82960400001)(2906002)(38070700005)(5660300002)(4270600006)(55016003)(38100700002)(558084003)(6506007)(71200400001)(7696005)(9686003)(26005)(186003)(33656002)(110136005)(316002)(508600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjRfSbzQggCF7hBUJITRnO1JRpc4ZattwGSbMVnnXOEs8nHtCwjvJlTFgaSc?=
 =?us-ascii?Q?9ivjtz4rReMNfptBkCfeEyvP3y5Cc+0PMQAqiT+15jGK8RrWHBK2t+8u3LjY?=
 =?us-ascii?Q?U8mfegu4g7KNNBTNg0ERdmC81nzfM8sLtNVvKZ2M7ZRcRkD8BTgV/E4FYthe?=
 =?us-ascii?Q?2lKoy/mtoaYmE3LCTlyBxXFvd+9S5QxzFbICSMATLSsqp3AI6iIjxmKMTCxt?=
 =?us-ascii?Q?wBP3Pf3gqW3cbvda1wOCMRq2yspONJv0cu4tEmI13a5ZsarF2sQ2tfTZK05s?=
 =?us-ascii?Q?0Vaf9cPoSOlncvcKXmYpxaZwndwZRK7v4oDj1yMPS78ijXlGEZ6MB395wEtF?=
 =?us-ascii?Q?5RqvfJ3/uQdPMrwzc9W7iCIlinJAQaQWehtc1yWeDMnwlwsGEk0jbhs1O/ui?=
 =?us-ascii?Q?+uwdO74ZzIBlEGQv6M6+vxUZI3v1Jl2kNqO2X19S119p+DDJy3taV4P68qvV?=
 =?us-ascii?Q?E3Vr6y5JporeC3wPqlP5q06z+CbifT2C4/EDwJGLiMxJ1IQbnfyzZlxjjpEk?=
 =?us-ascii?Q?aQkqchS9YLjiq9TvZ4qex8c9sG3dMUx/9aagUyDblw9zw3Zj8eGGsJ573Qvm?=
 =?us-ascii?Q?zAKByn0ZLwOKb0yFHZZRLg/u/ZlJmrLBhRuMk/yNyRpZEgfrmw8QFmyDc6as?=
 =?us-ascii?Q?6Vg29U+0c8n2oLMJEimUfTge/MzijYOBGTuqlo2tV7jCG9L1/9+g6ggCN/yJ?=
 =?us-ascii?Q?n0UfXX4mam1Km89IjqTSV/RxxdfodLC4ccskCsX/Ufg5YTFLUToJrQspmFVf?=
 =?us-ascii?Q?7Iktd79BdzfMsrWlrNQEPY94HGRVNqYLpsAR5EHiw2inrAsIiwXTg9JWsb2K?=
 =?us-ascii?Q?cDPFAMLFsZoTZ82jjlEt1ctWIzcdlFAAo9yzhgtnfmiJ3Pd0sMrMmY05DA/E?=
 =?us-ascii?Q?mcRnuafeHiSsSjp34VXNXbRwlryqU+peWx+3LtOYqDpxRyWnOQsES+smfQA8?=
 =?us-ascii?Q?IxuyHMOqeep2ANOKgPHXyE3ZGb3Bhguf8p10i9psFBvwlYEXvyZvXOSDPo1b?=
 =?us-ascii?Q?R+GUAJwF0v8QoQcALDlgxoP2ypMFq8+91TyoR9p7jOeMWKiCv/GCmcKM57OA?=
 =?us-ascii?Q?iEbbeNRKshpPxKVIXLU3BCRRyOqyGP+mNpUaLVxYUNOthjggzQgq1/K7l8N6?=
 =?us-ascii?Q?gpl6VURyL6qqn8PFSvv+EVx8LggejkIzfag+XJP7/GyRPVILH6UirKhkP7dx?=
 =?us-ascii?Q?FBz3a2oVFyH0FVipZWIRQsnX9tSGUicGCJphgQrGVl0kMlv8xSOW9ABAHnXc?=
 =?us-ascii?Q?UHo8D/wDCj3D771bpC8XwPGgaSOr5eGNWYrGrvOs435LlLD6D4Q9GrcRqGhz?=
 =?us-ascii?Q?m6l71NF5JcSqG5U3boD/xKB4sgKEWAGjO9z9ZSKzCL2rKnsz2GSn10aK1LCP?=
 =?us-ascii?Q?tGrwDxMeQDq9N5Xl1DFOD6ZeMa/kDfFYsSq9jF6TNzCno1+jZ93ZIa2fnYNP?=
 =?us-ascii?Q?b+bOgWew6a9Ddzw/c54Mu13BQZLaucuQ5FutZt6qYTvzYFEND51RE3wCOu7q?=
 =?us-ascii?Q?sKN7+wcgIOYOt04=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a12966-2a4e-427d-428f-08da03338db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 07:48:38.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AordNY2tDd7hJR82Sz2QrkZoiHpFfa2IN1++fhcS2EEDB+kbpaD7YlK/rSbidIIWBUXNmOiVZ5//wO6+W2AHT3o/M0RkBZO7yVvqi8OaVPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6982
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
