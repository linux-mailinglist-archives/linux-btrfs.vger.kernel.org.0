Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C34F7643
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiDGGid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 02:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbiDGGiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 02:38:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DB38FE5C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649313373; x=1680849373;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=A1EED37vhc7TloiUxXcU2TIR5LM153P83aYV9baz38CxVi6WHvl3SpWn
   SgYaaw3j5lmh+7A87Nwo9tr7qIs5uMPHK/VXvokgj0CUun+eAhvDuEPoS
   Uixi4E61NVcN6HQQTa3yl9J77YjTpNwJUIX27zimOqkjzzpOGF46NJvjU
   F18dZqQetqn4kyow1BWifbUs+CUY/lMkOqCrfAmc31/Y81YFggEcdrtwV
   TQnO+U4LHgGRIN+GqSlElnEn5AYKwrv3YQ/CsylRcuHkq95hbQ963qRl8
   6NhE7GRlD0DLwtGKHn5Uk97NggBodqxn+par3CcRZYT7TJF3QKwKWnkor
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643644800"; 
   d="scan'208";a="198218235"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 14:36:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7fks+m9VGcif5cba+8oytHW9vewnylA4kahJt7MchgbIlozR3zK4d44DOY2qOGo0Rd7RiBC0Guq11CnH2MlyIlMT2NRuji4rGNKqxYNcYzLW/Pls1cp7wxnQVqZYkLMG9bczPe+CxVHsn1k/BJMTMJu3U7sngsp2kpBkiaPafUWjAvOxM7Vp2qdJGYbL6cBq3kkEVmwnN68m8UqMJUD46jy1wIZL5241EnwE5fzXPhzw+sLHhj3bPs/rQC6GqDC4ZZnqdZ1zW7Qe7NvxQdcYCVwBN9sYfPDw8bxsKkO5ay6Zd0b7EqCx3tggzQKkNLctR44xwZNs0KdjzzkwA5WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Yp7CSjNtpxubRHVAck3d7Tp9zD0GbjtgJFgCNiAclwHyAZSOmdMeSDdbUN25Prx48ELwRM1aeYHO1/f2MnqkJwjjInQY5sJp1C+zViNbGEE3//eyco5O8jsnym9rnTz3d5YTCEyDFNfV8KNEVqjtrvrAs58SBUSfWyf5M+tIPqZLVgDYlVFDkE47C9x/2GWLEJ4k4HHCgDLmQY5cj9+p3YoxsaJrryXmFO3Bl+jKFvozvp2iHrSLK216JI/6/KhdR99yU/GpfoqiZ4YB6G/3SasO1OaFHZZFDiiODfUC4n9yMC2hxRXOzazSsfMbjJBw7KaJEeRwwnOldNqyNwSsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nvQ0TD1E0F5UbJBtyfMvVDgORAP0wKUgT4T/mDtxhBi2k85FSrES7OHUWLmyTKt+wC7QBt2/be+2lmMQ9aHdAjt74nGGI2obsJl43eBVoGQUJG2JHNIO6afx3HZCsWradAH4UDoWnqd+9n8r0VJl/qz77FV6QNd9xx1J9mx9PPg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7854.namprd04.prod.outlook.com (2603:10b6:a03:3ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 06:36:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 06:36:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: fix leaked plug after failure syncing log on
 zoned filesystems
Thread-Topic: [PATCH v2] btrfs: fix leaked plug after failure syncing log on
 zoned filesystems
Thread-Index: AQHYSeAlpUUp8tz7+kifjuHLsIZCGQ==
Date:   Thu, 7 Apr 2022 06:36:07 +0000
Message-ID: <PH0PR04MB74165E98C5D3755B69C0DB719BE69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <c766f439fa12967383d8e62c6f5883bd1f62c483.1649245880.git.fdmanana@suse.com>
 <7950a1a3db370ab5f38e8da4f43b002e11397b18.1649261167.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 437e4f76-e628-4b7e-f059-08da1860e5bc
x-ms-traffictypediagnostic: SJ0PR04MB7854:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB78547E4718922542E13B0AFD9BE69@SJ0PR04MB7854.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ug72TxeDXbY8N0KZ0NQ7lpwQRCiVSKmXnSE6vEryOQ9vCuhm0/XksFaQTq9p/cJZ5nDgJdXLgeLIhRdCx6gn7aj7qj6S65cJDt/F5gyw6g+jMCVFleoXDSByQF+xz6qe40MUJ2smZIZT6cyqoAJq+9NtabZO4qdZtgbzSRCJVwDP9D/0iNr+f3obR6b3CBxkwHe/UDp0CVcPIvX+KSK7N0CoxezBV4k3wU3HdJLCeggPdgXxewkFLVSsNwPCF7QB1vVhcHSA5Mw5qz72aMsB486vb3g+VtYvWNMTT+Y+ZyHsP2hKfYbFZbJd5EEi4ZXufvUpHuq1MFYWgECob7aDF1ENOcmhTlO+YRNkgqHbkTB10bnPYViQTURDBt4NML7kHlLhfG3rexUs43VbuNR1XbPFyP6euNReekfZWbyPvpbajCypgGqDmZDziIMY1O+ytsGHpWw21c8ZhrZWQgZW9+hhcpHtUigINWLXBF+tHPttdFz2Crz0sanrfLeydID13o6hjdeUzIiwzxxOuz99k0uFggMjj54jXEzJUkNrey9Fq5k0k4ehIT/cGqD2ipii7vgi+awntGe8aE5l4bDmHtGn+Il5W117Ri+rZT2EzBMeLnXmmAeL5MKP34yoCcD/p4WuVFQdAB71UBPy7p30EFLbgEgiAORkDkXHwdUhibR0cOz4QTOqH0/+WoU5kwGgQr87pPRQEfF67E76W4ftjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(76116006)(8676002)(558084003)(66446008)(7696005)(4270600006)(66476007)(26005)(186003)(64756008)(91956017)(71200400001)(508600001)(66946007)(55016003)(8936002)(6506007)(52536014)(9686003)(19618925003)(66556008)(33656002)(2906002)(110136005)(122000001)(38070700005)(38100700002)(316002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwuMOyLAj7ZBbnpyXzyFMieo351DyHYC0sXjAZ9LDUXwfHjBF6TLZOKsCgMl?=
 =?us-ascii?Q?1QEblaav3yD1qhLOphDgFHTrlH4uzQQX3Q2oJs8OriloblPK+ojbwszFZ3vh?=
 =?us-ascii?Q?hI+7ua61POZu0sQH/maN8/1PH8M+mnigw/l5w2zoKSdMQcsj2Ei6kFrJvGrf?=
 =?us-ascii?Q?hyjpbE4b/8GJjP9Fzs2idLNKG4wPLp8rcEhZ5ZMbzK0RnzdfVRduWy+GtJ+Z?=
 =?us-ascii?Q?XBRpbyUXA7ZQAV5B2LoZ+2AaYh/hJWkKCrF37khYtO/r0WzCyPGaeIC3rNdI?=
 =?us-ascii?Q?3G62qs4I3k3aZ1lWeC5uyYAHawyP4XhCNAsXhFkD5XIu453z6jMLghuUblq9?=
 =?us-ascii?Q?ndcQBzA1QRxCIRKt7Le3wxf2u3GTk+4jUbRbGk5uCFzIQ/887a/IzJWAtimQ?=
 =?us-ascii?Q?brWFmVYXvDu6N0udIR+/h668Nbx0S7J2DqXq2RZ75ckCp7D1sgbGpBQ7WWj9?=
 =?us-ascii?Q?cYi+1mLnS6MysgPsmZsVQJOY8uJuuzbSkaLptOT8WbknkgL7U+eawdZFIGNX?=
 =?us-ascii?Q?ktmJGny61kEdOVIA/70sOLK1HOqdvA7O+nzcwdGjvmJTBL4epLEW3G60A+uk?=
 =?us-ascii?Q?hdLxA7cObFMXVgBddKLdhg1IXgsn//zigsjxachoqqdxL5QbcpvUo03ralNU?=
 =?us-ascii?Q?Nmf69XkSK2Was61E28oeeWFT07nCiHOCPY10NTbPJCFjDn0/zR+bbq6ldGDP?=
 =?us-ascii?Q?MeN56Q/G2ObPsdp7T8Xl1OhG3QcKNkMuTUYFZSiB+8Mxs/x5ySbRPLfSVFDf?=
 =?us-ascii?Q?4OWm9mu0uAKcsNwwN1IB3LggZ2etWQYfvZCZBepl7eCZVcWZiiTV3vNr61o+?=
 =?us-ascii?Q?I/1rd9PivAc/FhHB3LAQdEtbqXTpOdCPvLOgt7YFlo4XP09L+6ZNfwU2xzUt?=
 =?us-ascii?Q?nxBcN/+d3T5qFTeuyuszADc/cXAX5uoyYS7FcW+1YS0b+kBYS+6rP+cnwsy7?=
 =?us-ascii?Q?aqveh2eMFJ24zf3be4nGGMaqH10ggbrvzBZpO1qDGr8FP5DUt/6Nqb8KV8i7?=
 =?us-ascii?Q?NULT98mgtFPP1MfvUfwUPalIV1S8BwMPXV1irMr8zFW+N2qa6vIRcN774sk0?=
 =?us-ascii?Q?zaRe3iWGWuzjAweRMR1LOFe3r5vw3YPKV8A/IPLtEx3p42bcxtaEDJ3nSkKw?=
 =?us-ascii?Q?TBhH8/KN+slDfUDzrXX/DvH5vFuaZHcnYTEi05EzKzaVfgYCFTFcK6dZ8IIi?=
 =?us-ascii?Q?RUTaRm7bQ9NlnNItji064/0BKjjwf+gY59zTFe0bWfkgG/w6p04gabNQWt4h?=
 =?us-ascii?Q?oZM4oePA6D3FmjdVULw0Dcrla729TZWzS2tIrq79zxeVg/FVcVmRvSGoZOA2?=
 =?us-ascii?Q?X1LCt3R4icD8GjU+275SgnmQRCUjAiIddF3FXBNUZyjc0F9W/o1j4hHKUbir?=
 =?us-ascii?Q?2E56ySfJka0/5PMVD25SwxYJ4jAB9gMfb4m+UTjjykBFC/15QAov5QXVYDos?=
 =?us-ascii?Q?ej11yMPfVc2NzeunFhDRa2o6WOXglcBh985NdR1LgZDuJfQPKmtmqtMy0r6V?=
 =?us-ascii?Q?57RdrhLzejt/xv0y8huLYUhPdrAS2FouyyrTJ85cpMj3UxPQLtrPTqN3wlR6?=
 =?us-ascii?Q?Xo00m+gTfWcNHRo2e6W3qfW1tQ5SXAg/dVRb5yPKjLAxnP4q6/3Ga/+VLBPG?=
 =?us-ascii?Q?EFGx6bQQSn0DuippppgcO1VbjEysUBMFNK6htHLmslgDJ2V8jkyZRtXI9zmD?=
 =?us-ascii?Q?u4Dxn328EQSyzjfF7PNf25J4J8NL9towlKHZOunfDDQQDsBqldJHH6LdJlPD?=
 =?us-ascii?Q?0vWd2agPoA7j6fW9l0IzO4kRyM9rsJZSUOs1qsWJtpTJvBQanLvG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e4f76-e628-4b7e-f059-08da1860e5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 06:36:07.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0cxOMX6GHKdemQz4BbcvLV7P5RpWbeGA/zs1xplupDRQ0KuEow3dBMHLw96UtIlDRbQZS+Df4qL5DiBEBnY5mPlIct/rY0DzSaK8w+uPLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7854
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
