Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8A5B9C62
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIONyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIONy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:54:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1598D31
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250065; x=1694786065;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=k8t5nOiuD9jzEownFkaZH0em6lc0Im15uSmP5LjYLSm5SMk5uVEr3FQa
   kw9UU95kBuf3vThmLpM5jmQsBnFUmFdB3kEO83KJbYiiGwOedzCef4cnM
   Fms96R4C4m1S73EBJuzhRunA1SV6on2A5ti53UEwTZvnFkCeR4zM2d+YS
   08g0ws32/7TG1Cc/DJvggSHsb0QeGmmQNux+2B2yoA/3CRCrN8PWHrPxW
   uG3DeS16iKF+UsHxXT5NGuFxn+Reb6z2/wwdVnOK1yj2NJN2YN4EQspH8
   BE8Fhz21wH5xL5oUE/CcJGHUxG9FfOMrnFKCCtYrA8MlK6bQVymJ1MyH/
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323541848"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 21:54:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnSSMki1Gtwa+RPuCZa/92eXb42LhhE9dUGjU2lCMboD+cTIh84bJnId+wVB2tndC1oxtf6nz2pVyp1c8scmuTLyMgJRFgFTllBM+NrvKghhwFbCyl22Fz597BU63QeNSS3hHMEUFfdMDeeGoqEE2H0cSh1YOxYTwpnRTsKzOvhc5bdKuUUWFfp8GrjAxxHwSZKJtxGizimchfbadVBxJbVDQAK/q3NrbdeAoDGLAeo/5pZq1v5qVfXSyViZN7UTxZfEUMpTCYCtvdqTqRAAVtCTWEEDna24nVkUL566wefIUwUfB12JjGi5virsnFyBSCNXHW3CJQLVCNkU32iJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nSAyOGuN2Ss6vxZwJRRo+gKeC/9h6DvGG8NOP5EgccQK+b1Pc99rQUM92yXQHw0aCqccs3O4lM7qjz2/KJkA4H4CjAWqOod6HpdvSf0wtobwftTkUCdb7GTuEwSazyFx+GcjjbTNaGh2kV9poOk0DwnFqymr38W1SKqz1Qq6ZI3ZgV9Hjsnb4uO+jdXCEG0Jdkp84833qVVy9aCVH6o7F0w7ZUoA/lta1ncudIUkEVdIAkKnfwhH78QhZr9h0xtDgpW8I3znBLFb68hYxwtXFLRGJv1q50t30m0BX8pGsZzpwvNVud7v4rokYTYp+NBOdZX3Ys6jZMToEXgwNQtP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qrQk8H3t7dvQeOvZKq3JY/dCRZJYc8Vhn51MWZagtll7VoIYEsvX2c25zyT13F9/TDD8x+gv6AHKVVBazvxU+6A7+i28TYFYpotu+Y2Yvtls83It054qFxNrckOMzjAkeUkga2teAMn6QMPQrT23VUk0Qli7D3EzUfJ8aeXPsxg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2259.namprd04.prod.outlook.com (2a01:111:e400:c5f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 13:54:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:54:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/10] btrfs: add a helper for opening a new device to add
 to the fs
Thread-Topic: [PATCH 01/10] btrfs: add a helper for opening a new device to
 add to the fs
Thread-Index: AQHYyI7ZbGguYi0VGEe4UZQ3TlLBvA==
Date:   Thu, 15 Sep 2022 13:54:19 +0000
Message-ID: <PH0PR04MB7416351ACD2F820198B952B09B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <280fe61f3405e88a0a4a5ac0cacff3993f9f31ff.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN3PR04MB2259:EE_
x-ms-office365-filtering-correlation-id: a33d35a3-d97a-4d5c-16b6-08da9721c966
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XiFDfKbm/r7QgnpI5PxyatAmF8pMRvSK49bkhw0HKFz3P8udU20iIgpT72YXIcFAl5B6NVfzUOEv5PdidnP/vmPOQWt69mdJGCle0uToKpEbva9c+YOh9hq4ZN3BX/9ZvgFjGqwdc+Qzrx5pQgHkNuG4L6Mmjdck3QBinrUBiaLNLry46kafYH1dWnngIDU0DFyFoE9pw3M48rSJIu4YoTUTUnBrJsSUhg2BKvVQQTrI46Dk0Ql5TC/5Iv5zYTcbozyIPytXHw+5z1eRNTXSPS89+ebPQ//Zv/cLkV+OoQBDtFoA3u3Hfel3jFsEs11mi8Ki7ExTzna3xF2YejlrDv/gbTMUxBj59HZZg+gNkY3RY/I7q8KMwb5ponjmWWKyPIcrvIjNoa7ttiDPcsNbOhpsXQbF4jA6eb6pA7YnZ+pp5o2geh012NsJbBJMnvAFFteWqT5N4PlsgGeosXHYoeyTKA+Ob9SLCHR/tZto/+hR0s2TUXZIC2vVG8OitPhsdOeJP5/1p9Nt7/zOblKp5/0Rqej3+OjzjAFduEnyZrzP1MlPkcy/Er0rNUKWj3V6oXCggUwXtKCnCns/gHuqQ6G0JohLc/Ywk8YRLWSefoi9tEym4LzgD2QmBJ1VuT58O0wgpMjg/2RdBfXg/KnyoUqkqfeh5mF8OpF5otPWs3daRGyv3xQzGGmsqvUmJxhAXFx+FRHe7khCyPIhbphPwE9663vOhLQHCg//ouJVbysB5p63hEgrIqgZVy6Fd+2be/BiIlvQcl+xWhsW/iKJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(558084003)(82960400001)(186003)(55016003)(478600001)(6506007)(52536014)(7696005)(33656002)(122000001)(5660300002)(8936002)(38100700002)(66446008)(38070700005)(91956017)(41300700001)(66946007)(66556008)(76116006)(19618925003)(64756008)(2906002)(8676002)(86362001)(316002)(110136005)(9686003)(4270600006)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ArTWaiakJlhsFZQkYWnjIT+4ii5mU5hz5QbeUmARfIqkJbujRxZe/wZTATb1?=
 =?us-ascii?Q?3E4MNtSWRFDWbZBn+ujcvdbOUQcMG2vojltKiKkWuD+cCik/pQ9xu2ELo1Vx?=
 =?us-ascii?Q?aL0eJgnD4SvluCP3R2hJwgVyI4B7Pi48yJqLetab5V8X7EkpgM0+X+gbsD9A?=
 =?us-ascii?Q?ExQCrhYg6hQtAqPdsvQ/2OYBeLf/mgodWm8G52Y6xrowOvdkdxr7fuAbZS1W?=
 =?us-ascii?Q?jY6PI5WQO1Gl/dTJwhhath7Nmp1oXRQudfmCZ0FrOMraWCz8OX5WDfC+Sdeu?=
 =?us-ascii?Q?IEvCyqMP0XI027sI+GHPp4jB9lS6b0eiZru+B7bGAMfbThJWGD513LKmwd/x?=
 =?us-ascii?Q?v5yWjbbDIAto8dNaG17WH0tUWnRmAYvYILX/KB+QwfR933oDK25YTAyvLsFF?=
 =?us-ascii?Q?2HN9VQumAgX5QOP3aGhOutBvS6x7xAhV6TTOMBQ7ZF2A59phvKLvB4gDKQwC?=
 =?us-ascii?Q?ce06dbsbl8rYxYizciwH46HSIjEf1ogm7G6yKuPWn7k5vGDGOrWiWzIxaHxP?=
 =?us-ascii?Q?dI+HzlDWApm7+JE2eJXNQpS6RB0Ajo6MsVbohR/ASB93elTDc9nruh7F45/B?=
 =?us-ascii?Q?0Bzx5zfmRF74XoTD9qHdAz5ph/xRaSx1Ki3ipUIszXrDCNepGtyPC0JeHv7W?=
 =?us-ascii?Q?cDqNTEw+13TWVtZkM1Cv222qQaSiy0mTMv8ULOAWlNhsmRXyjCjUjHSD9pNY?=
 =?us-ascii?Q?OpYq59X5x6uZkprLngh9BeCe1WRFnGSypoda0JRg744+IO997f8DZ4kk93Ah?=
 =?us-ascii?Q?Qjr0SwgVhjbr4u9Km2/6wMTK8HwcF2F5V1HO5tnQ4YmLb2HLehIJUt49vnM9?=
 =?us-ascii?Q?fXqktvVMejOteM/TgHjP3weEUKzrW6RJRlJ0mkHMwjFYz9bm4/WM+z8EBuak?=
 =?us-ascii?Q?qFdDrbuSg34FUPt0oCb0B6ZGApDRTjc9zLyJmLm5ka1mVvEgXLFglmuxUJYK?=
 =?us-ascii?Q?XxhS1eNZcztMZUG7tfoNfnP3PIyyUO1/nUZENiabMf8cRR5JLvlwW7spHWPv?=
 =?us-ascii?Q?hZLrxLX/JyN3hk8MNgVKvoDHIUAnalnk5XKyF6jIxSepvnqUiXSVM+Uenp25?=
 =?us-ascii?Q?mtfYkM/vFvg1tGzaXT6i98+w/0Sl/i/8XDuJGXK10nb0R08l8pVgq/yvIJv+?=
 =?us-ascii?Q?cS3AP3fW6ttLqs1ei/APIqYt7p9JEU04GFtaE6nkVPgXPFEDHK3iOnVVDtca?=
 =?us-ascii?Q?erzOaj0BdQD7LSPzr/WcXqUViO6MEa973Hc1PZwLhg5UQ4XXZE9xNK7CM+Hh?=
 =?us-ascii?Q?kjd94tdwANqob5weKqTSrXmAGD/OhMbyprMiDSIKhwLiacAPoMLQh0Tnbhsu?=
 =?us-ascii?Q?8KcGs846kBkiq7UC6iSrKaApYMR2evHCbE0FDn5EDhHxQ/S+8v1An+zkdSfX?=
 =?us-ascii?Q?7Y6fetPKLkcLD+pCkSjzfa/k2p/cPwOIPuSJMWv5PLGLtSo3dSM7UsmYExTp?=
 =?us-ascii?Q?ZrWq8hViabNv5dlfxVUSdMI2aiBzn6RqlbCnB57GcWdnlx0Re4UyuALb8KFb?=
 =?us-ascii?Q?7ieBYuX553FTKL92n+ElHd6SCp2W5eZnqu3AjPIiAiOdTfI1woE2YwUJiq8l?=
 =?us-ascii?Q?A+5Sm6vwhSTHWfOX8Qpkh0TnZCjvx1RBEPuTWKkPyD/eJLX3OXy5a4J5XYqw?=
 =?us-ascii?Q?ADimTtdaar4p2wr0/Rh44Ut6MzvPARdNRV6SPtYW8NhCW2djdo9WV4afKN6S?=
 =?us-ascii?Q?OZCeaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33d35a3-d97a-4d5c-16b6-08da9721c966
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 13:54:19.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIfrcCf/ka3R9QKHhFcwSAWA4qwz7mgNB09Zgr8QspBgR7Q70rInvlXv8sAXpf8fjqmrKe88kjGBgqOLsus0Jxo/+t616E/nmsp2eZBGScg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2259
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
