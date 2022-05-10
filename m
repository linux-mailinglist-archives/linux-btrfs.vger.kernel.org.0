Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C9520DEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 08:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiEJGjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiEJGjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 02:39:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3416B285AF7
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 23:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652164517; x=1683700517;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lmJFUAD3QHTf5iK2yQoMY84omoQwpW0hrVy2atpR5DUc7fJDjdaRbX+I
   HajmXrsGUnSmocB43azMjltKG7ZGeRVOSPLBQqeljNTn8IfN/Ggzzoio/
   kOJf+wa+uD4dRoZE6rab8Clt09RUZS8l3TJXti7U7NajYt5pPCte3wPvB
   0A4GLjtH8FBtdaM3HtX6Dv6OjovebBjlSlujjKlfD/GBIypjijCov4RY7
   fbG/uDnGLYE4s5RqYPafIjZM13zFgZW+YmcK+9HI/bcTzDkCCTAdHqXfD
   qCeXzlJnSRJ/vW8H7pvWrjlj/dASarYBTOITiXl3kcQWi+QHPdsCDrnlh
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,213,1647273600"; 
   d="scan'208";a="198762036"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2022 14:35:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAGTn5YWO3mR/7dbZjizu6ArVoBZ3G9jVNLpGznlA6T6jpsHAz31oByNOk51Fd+J6MQ3MjN4ziKI5WhDmBfLbNBDEglb7cAeLDcdzMkgcMMT7uMl7u9CYUFzUePmEAgSiaEuXH1hWWy7e4GmZ+kKWCnYKzkZN06hI2NyR8A83nIbwheaGhMVUBBu5SWMZqSsP9p8fmYHLrt7Ikktt68I8SyqvygWVXKLetPD3mzlEc1arWYXs+YEvBu7yj/Qj5iaas9fANCzEsE8pNu7L8HPtRgWZEZmiWjUlJXHf88gJb7yg5l5D9XFEcLP9al7UO+XK0DNwEOXLUIj+DPxyRTnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ALv7BYSlo0l8caQCDH2FYwmNlY3HQTMYbu54BCKF8AkKqs12+6p+tjhaLTF5pFE7w4aqf26Htv1DU1aWuBTOim5Bro5YMd+3FEpOKiGNQp0P+xTfrCR8CX2AEuD2ZstRWKzLcuojieJSX4QkLS8M6CXU27h5cu76C1tuQ/or3t9YVUSD4Yslo4rPu4fNvMRcmeaN2WrSzQu8NDO8qdwZyfT6EtVf1/eKwTbGyHmSl/9izf0/q+XIGZQQQBu0hIePyVh/ZW8G3PYQZ/E6GdXrx6sUfEViGyrOETovs7izsl54ofYd+kcWDIZTusXNIcrfMjZXtN/VfG+8Vt4c99j6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=uJutGOZFFEHUjpENNbtp29vxDX204hcIShXzzgg6UWBki8chf/owpzjbH9Ub3oBfj8RgD3OHhe/lb1SCOED1Qx9Elo5gy7BL7EL6rves46Zo4xhyqOs9Qt45dOsItNkVw3vSZ3c36uqxus3HddJejG266rcFfur4Tpuq0k3TTl8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0941.namprd04.prod.outlook.com (2603:10b6:4:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 06:35:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 06:35:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Thread-Topic: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Thread-Index: AQHYZDOzyGw7eozhxEmkrWYbC5lY2Q==
Date:   Tue, 10 May 2022 06:35:15 +0000
Message-ID: <PH0PR04MB7416EF0B3F83EC286E71EECD9BC99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e675860-b4e0-40fa-812e-08da324f3e43
x-ms-traffictypediagnostic: DM5PR04MB0941:EE_
x-microsoft-antispam-prvs: <DM5PR04MB0941AD1A7ABFE15F35CE868D9BC99@DM5PR04MB0941.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHcaimudTyQKDqUFJ/AIagUMubJwORBsSkmBKhhrioD/dU2nMvnsGp7d7jOQ9lbXjz5NjXZAh9Jlx8RqfndHgGQtn+tnF3kIAjzShffgiRYPbWG1/lvA2z9t/mGsUXZmAV5D1QgZycd2Tyeoj+7SHBFECCno8JAyxb2PZ37XVxLkeqHEoFAvkQmf7dBSwGZoK4naxYkrcXAIj2ByKGlZlL0oPuHuE+OOdNGIJ21B4x+Gd5mOT2tBPtXVD3yI3fPkQYBzpwhI0ts07qtCCgdeMwsAb26YtleGcZAlDodiFV9ECuUNcH9vlR/+6dSCOicPoaOq7XrR8ASIRi8ZxqgUGVNsSsRJhFgL11S6BCHGSN6aViFlyXRjkiUZhdtCIIsfzOJpjTpLsqzSVf8Ffy/yoSR/dpYj7QejuAoc7baABc/HJ/puDt7e9u+js2qG9otO/Aaqy94GL9qcoLYIRS/eypmQ0jzRmd2uQ8XvRxh4fHjcF9ozgnEA2vmCWIcyonj6KG7p1b67wkxRDHhwE9oVv8nAf3NAvOK4AJB5SiSCQztEa8Ny/GgcMZ328i4slE7Ov9ntszeDdDx8dGvCL1JsSyHn9eBz1KbjGkfsn0mbAbz3mMYx16UXs2YxggXuSYNm9Ic4WDr50ePYIXaaXxj3EU/O0YyV+w7HH8NjccaW/1cztuaMrS7cYAXTtq8b2Wfjzea+8ObXEkjDtJzEpeiJkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(8676002)(8936002)(5660300002)(66556008)(66476007)(66446008)(38070700005)(38100700002)(52536014)(64756008)(122000001)(33656002)(66946007)(4270600006)(508600001)(76116006)(55016003)(71200400001)(82960400001)(9686003)(6506007)(186003)(316002)(2906002)(110136005)(7696005)(19618925003)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RSywTQFE12g+dfszCfnYQng7SpBw21iM1vt28QQ58hnASdSGmyVDgmXCFMJZ?=
 =?us-ascii?Q?JlX0NeE8KdCDYpDYAlUjMSMky2FuqTSKtrC5tw3MxHJstM0++qEVOHjKz2AB?=
 =?us-ascii?Q?TERoxo3q/0lbCKTlCU14KzbXnUx1/ktf5jDKKgwhtEZf/8V+qQr5FZdi5VfS?=
 =?us-ascii?Q?9GN6CxOXPW4BB//R2UajnnjbQ5IJagXQQ9ao+YiQ22yNkHkLRwbOjdoAlJ5m?=
 =?us-ascii?Q?IONqiOE5TZn6T0yjYNHoimxAJDenGWLFOgHeFlEdV/aUUgHecGGxSZIEDcxS?=
 =?us-ascii?Q?OHxr+M+owLNi3SdhCgtMGXuSUYhAeE5VWafFmRhyo4OU1nsUKYdsr0WByPR9?=
 =?us-ascii?Q?85biX4jBM0fhgG3mzWCWPssHLyhyn5jVlK4zwdRQppW4NYIYYG3emR4hCZ4g?=
 =?us-ascii?Q?bOlMXg/ar5+bVuVXnv3lKMACQ9vlDnQjc2FEUO8TLvMmecsm4e2tLIROggG/?=
 =?us-ascii?Q?OFWolBelmdJDKKTmVZG+BYSP1taKMRpMoYPW18a5cbP0F0QlnaNrIdfWifyZ?=
 =?us-ascii?Q?2eFl5xBdqo36kGQAF/nUa/ByfLxmFoBAxSJRmMmEjdFkcRcCPqDgHDE6EIuW?=
 =?us-ascii?Q?zf3bxa6OXSaxnYUowl64uJGoaV/yXr6bo2G6PCXzCGeVGTSIBwiVRDabeEBf?=
 =?us-ascii?Q?nYbtvJc1N9BzO2M1GVZrnsQ+QIMdB8u3Vwnr5ewXIB6P6SOsFfbvlVu2b1YO?=
 =?us-ascii?Q?pwqb4AvZYEpQ6CDXDH0UEIhA7+kpl6nMZh+ZTYInFHGeZdGKQ+6SOQ4C0CWQ?=
 =?us-ascii?Q?e9twI0Z++v2s9qvz2Y9GFHpw6w9zQD+YqE/4y+CVFbOEuVV0hXr0DJa+WmAE?=
 =?us-ascii?Q?KytMI+Cqsw/5bmqAUkQPuC6PaW2Yor5FjILskP7WMXnPfBW6kuincD0gSDdx?=
 =?us-ascii?Q?qzyClu5c4PtHOYTDxBLEML0DhcGSmtvvC76Kg7JFv/2Up9g7pVeIIFG0Jlgn?=
 =?us-ascii?Q?tee1kte7r4Fb8ttXhHsfEDZRVZkznkdHwCZ9puxf8/CTI2vkijWxt10eV8db?=
 =?us-ascii?Q?x1iPCwHtnH75SL063vw+jeN6PIlhJMVQffcroUckH62TtZEW43U8p/PVGQgh?=
 =?us-ascii?Q?ksIVY66lq/5304Cu3NwFV+Z1IflXBUbDV7qukJADwERMIiTPMU5UxkTeJ4N+?=
 =?us-ascii?Q?Mjq4JfSNvB8SDf9DxAF1QUxIwA6O5IAfEA7IKTFRONEhDqePpBIhfl22MkyV?=
 =?us-ascii?Q?EnacWREwfLygzT6bZLoTFaVdwh/iVPlA/Y587TpUjwTCOcMnChVuPKFP8iDf?=
 =?us-ascii?Q?t1sj1LKEt+FiC6dLKOE8nLqgn81n220Mwfpsz1ArLLyz4GW1P+CghBaz9CHp?=
 =?us-ascii?Q?QIb+jYJ0Cqt4sJh4ki46NFMHdqEQB6NmYJaC9hnrlatZpisLJ7HcKnT58zeh?=
 =?us-ascii?Q?ObJlegX9O8IyETYAjei7TPI2XGDBR/KmjhV+cBQtlHWuGLcijKCs4cOUHXiH?=
 =?us-ascii?Q?pwQaoN92US/6kAXSXJAbaoCTtni8YN5cra5G3qes9xTfQl5IBmfbZcZfNXcm?=
 =?us-ascii?Q?JjxyU9XVcVlFM1h6RNwOomNovtgtFNmqsykEMV6wUb4Mr2q7fuYgKF7W4UY/?=
 =?us-ascii?Q?AfgaQrfTFMvXooRxeoR+Jz6FQQqCQ64m0VyZR05K2i39Qc8hkl4RgSkGMJev?=
 =?us-ascii?Q?uhnZyFGFjL+2qmOk0rjHPHx5hlGKK2Uvk5K9rGvI4+/aWbXnyjjmwGXPOY81?=
 =?us-ascii?Q?eM21ElUPKaNjnl5Wt8woIf5qivsvRloR+Tbl2iVIqsmn0xxOXb5Q15ra7Dxn?=
 =?us-ascii?Q?j1rknawIvjeo2CbkFh259hwTIbUN0EQp4OaBT9owAK5FgXMRY0H1RkPcJKYj?=
x-ms-exchange-antispam-messagedata-1: oBBNAfwdtTbGwbjIEcfVVUVwWzt6ynxFg6KxEtGWW4y5KlQDK8B/PuCN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e675860-b4e0-40fa-812e-08da324f3e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 06:35:15.4450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFMt8Ljgy0oLkZbOdA/rhmFlHHgF03CRoMnSiNSI+xmTsWLGg1sN7Y6kUpxulmChk9X76AdsQ5Rsfyz8j0qaVZY/1qBOCHHakw7Ek7LBaec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0941
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
