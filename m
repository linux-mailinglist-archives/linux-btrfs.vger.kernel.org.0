Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125555F8EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiF2H1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2H1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 03:27:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC035A95
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656487650; x=1688023650;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=O+mc+1jQH9H2VBsMCX/2Ne1ILsIUgGt2aZyNvzuhqTlrGUaLkbrxq484
   uHti7+1bHMZdMXc0W/3HinjeqSgDB77hawcACwN1WxhEy5zfj2IfsLCWR
   4/jOedPi7yz0DGAYKil9nzGbweqQ0ATv9dvyxaRJUHD67291AVRS0Anyf
   lNB85KIzulLTw+XpN4RQ2GWNgpg009f78Y0/ASXrpdsqA98aD3mKvbJK7
   o79bxHRGZaCTDm9BqPzmJS45XbGh0FMFhvg41n3mqg95/iEoYueFrOYfa
   dsX9RlK8WG1R2U61+6ZTXR7xw5znMGoeaWMMQNz7jGxw1/M+0lodrQ8Ap
   w==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="308686160"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 15:27:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO0GpW0myUmb73P7CZwqYTdjoc6naOYpfnnZtnD4rY7VIyrVVNmRKDIr9k7W44QqEL4m0rfj563e2JEyhNWmL216RO5dGGFmx8L1eP8Bx0gB0g+Zs8vU+RGol+E/yLIP0u0X5BFPyag9W9XQ+4ykuObBjCGOn+Vt8Ysze4bCGfNCRlYlE7ue0AoSu6SUVTREnYmXTB3Tm52eVYOZ4q9JLqQqUEeIPIwY773AIMThQqEh/DS0s0SSMGC+hmw3pxEXAggsKZ6zQwLI4+Fcr78ZcvGIK1eqf0bGtnVq46W20lJGoN5v4eMExvQp2qsxLiUfPfskTSzpbAiSypySBnoZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LbrPKQMabqziH3pyXWgy0GOBMDR4ZyRQnajyta3t0xZDziIOS/2ii6iuFHwpq3K1BwMwMXFehjrY8uISGQdUgLR8izDl8jkwDzMLBfLSNlmlMhp9qlAjAd91NqIgEJwqVPCCmDB1aZYGw9cwy/HeFBuhLTtMS4kl3NxMIyURDzpcNpkrVvAO4tvlur3gSwBSr/w0p6a4hFvwvexaQhkM1f4Nu+2Ut16fDdcGji/EfuvQYKcVADrQQ83MeIFBOQJJYz/cN9h4lsu0uNPAwVm+AyrCsTGKiXwPN9iYWFfh17Aies/KVwnsB0dlVi+8lffutnJ4auW5yc9hMQuJHdWvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=chyOHYUxySU+GYAJ7qvxepFuwj99572iYrmMdVRyqu5fbB++7oQUYUJUGDoD6Y3qxZDEy/QXsP5cMDBic4apf1di7wofAeV5SB6uwm0K2a3Z0/OVZTj3+sdldqLoDugaAb3a+Ad9zfQwFT7dcqNHpgvXJtTiG9P6rJB9RzPnSx0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5978.namprd04.prod.outlook.com (2603:10b6:5:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 07:27:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 07:27:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: drop optimization of zone finish
Thread-Topic: [PATCH] btrfs: zoned: drop optimization of zone finish
Thread-Index: AQHYi1xJOyKSRMqJNke5yohLikV/JA==
Date:   Wed, 29 Jun 2022 07:27:27 +0000
Message-ID: <PH0PR04MB7416FBA3EE1DA8C9E2D7C4F79BBB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <c5e53de667c5ec4ff49aa1719da1be7e1f80734e.1656467635.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597ba56f-c731-4399-ffd9-08da59a0d1e6
x-ms-traffictypediagnostic: DM6PR04MB5978:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggzQLlARFDedzPfqlwqecJYe+umnLO2UnIva+j9LOEFmvzYuAlYz31AaBFPkt573L3HAtki88Dj67WB98MySr03ZW1yQ4vbqAxPtoBpoWtb61XU6NPbVHYRQhliluXbeiDfqMewEH9hR4zISSKRcwW6r8JGuMV10/iuACCnR/oQ1MZC2xRRY6h3EBXOGMFLiIEL8dcZtjcyFk3HdSLTyIWfS0182KLkEfwb0pDCAZKyCVN7UYVNS7PH05CSmCehFXVAjuOUU6tu3L8HHT8LqdbJsH/z7b5D/vNbNoDs340Y8PgG6Sh46kjtdzySLl5gel6n1FzXms29v6Sa7U4ta9QL8UZdMMnpC4YFgKtmp9ezSkDrkerdRo00j88J46kIUNmrJ0AhGwJubvUtQ77PmUmYGW+K9HLI3QRJF8mmSOyFLIY3c0BF/n/W1Bfxo1rKHfxSdAiOte+wloUMIhK90ART06ryQRZfPtn9eCaPLT/TrTAtUgeqt9TzGGXLFJ4NjYwVkr4ijQiHbyS12fUIVGqiQsUcqL+ltmN4Lo638NcbeFlDx3e2kCtJftKpdi7HgDMUjLrkPJbzTb5qXZRnhLzreIz/X66V96IvOQfUjfMggnZ2FJxSSt2RQ8giGKJCKuqD7fl4V4zIGwX1KmMDYBX08BRVpA4YXR4e8r/zVjzNeJ96TlEUq4ldg6i0c+2R2IiNoYUr9MXCpFEXEMmCZ1HkKQGwUmxrNrMnsGrzBabscPAHWjuSB5BNQP7p9XaSakC2g1gHdgZ8otIltcjXu9hK785uOQVsi07PExWmetsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(91956017)(82960400001)(316002)(7696005)(76116006)(66946007)(71200400001)(110136005)(41300700001)(66476007)(19618925003)(66556008)(33656002)(6506007)(64756008)(558084003)(5660300002)(38070700005)(86362001)(26005)(9686003)(8676002)(55016003)(66446008)(2906002)(4270600006)(186003)(122000001)(478600001)(8936002)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5cS7selFrHnY+JhCzq4H2HsgFUBYg+bXrxoyiVhVnv7FsUUkUudU1jfYvs8a?=
 =?us-ascii?Q?loNbpjELvWI2c7R0+kNI106TUgmaRv4wd2ufLDVB2S/feT+Awhab8mH1AD18?=
 =?us-ascii?Q?+nQlOPl0ncJa740kprIhP0OgpqKisTAMbgTnuPXh0LkVW3CfKJsRkCcdkLJE?=
 =?us-ascii?Q?M7rf5viWgFAI9/BLwqjEpfx0uA/C3Pi+DK/mOeefrqS1wY304UVcWjhJE1z2?=
 =?us-ascii?Q?FozeUjblkL2fcGUN5WHzaBWoHqy9qf2jDLNAPfSLlDVPqMSkiUYa6EEKMLoy?=
 =?us-ascii?Q?jB3TaAKk+AyrJBNfyag0isgJMckqfNOhRWefHL5gaSaRMUI6y1WOYt3CUFUC?=
 =?us-ascii?Q?VuR2UmKctXi2cYlpvF+9h2vJi1OE1GCGV1XMSuyZWD8xzogM/SeRtCKbxFLl?=
 =?us-ascii?Q?OBQdgJpH8qzfeZIgWcdHgkeF+mPdBZZAZ5SLiHKUGWHrJBt2gs5e1N1G0TLv?=
 =?us-ascii?Q?tt5geyY8PXseEEjZAuTrBtJRcbwlFaEhJ5/F3Nox3wgG2w8oMRhTYiy/13s3?=
 =?us-ascii?Q?Zx4J+QNHgOfcLoUnSse6ZdFNYwVYI+unnS4xuvxqyAw+wgvknvwl4nsBC43G?=
 =?us-ascii?Q?FOjXkMrg0ziZplLWrVAjHiapOGTRqlBrfzmgR22WGkw+1jWVEKqp91L4n9OJ?=
 =?us-ascii?Q?t8q7a0VyI5qu/ie+1YFhXaSdURDN+MYDY9qN3gi06SEludU7Z077SnEPBrT/?=
 =?us-ascii?Q?/QQWrEXpKhkcI5DvmMMTVs49ypUYZi3HWaPLxRNXLNV/Akp2PZbplpxLx0Eu?=
 =?us-ascii?Q?npHLwrDVds0eC+HLqswECxIpPHx4SD1dpF90R3Qpejn+GZpQQL+bwpxGmFKQ?=
 =?us-ascii?Q?R7OU/HSWtj13n7T883eMiWwnh7lwzoD/tFnouKC6pJif51O/K5U+7+ndGz4O?=
 =?us-ascii?Q?d9Ykfb3EdIDShOuqUFJCwN/3Gb1Dt8+hAsr1sJO5BSTXRq/liKmWVl4eB3/Y?=
 =?us-ascii?Q?G8TQzGSxRHr/7VH1S438yPLsF++iUB1nUJ3ms3BdCBQAVi4gV+R6MKgrHybH?=
 =?us-ascii?Q?+x8s81RANMlEBZH4LRy7L05cNRmiYq2J/c4uqwLw5w9/wxxHRwjA49CFu1bK?=
 =?us-ascii?Q?dfJYJ/NYfmhEk+OjXiqSm/vl5D5e6zZXvTOFimPJ1mJ+3tuqFK166fFNcqJU?=
 =?us-ascii?Q?z7aMttS5OSx9u/OsXheZdutu7FsD78kUhnldwC2Wrm/ZOQIgpfoDPFxDyj7F?=
 =?us-ascii?Q?fbtiLn7elTTcOPtAIFJHBlaSIKOEWUoDd32Kho0lHX1XUqoFlf983av/5Tye?=
 =?us-ascii?Q?Yk7KOCgabTiKLd/7ZVdbxtn/BEO574I22yKKLoM0FRxNaUrWP5Biar+CWz4j?=
 =?us-ascii?Q?KuVdUR4N9fBRhqtLJ6MhuYIy9yWuTIVxnBCoLfKXk0ilOEAZ6L8wD+xN9Eyf?=
 =?us-ascii?Q?nGhIscWHliwCDsqDovVXC4mn4HI3vNOH9723np8VKh/4DvO77OCk/7APFd1h?=
 =?us-ascii?Q?DlwV/7EE8sodOZ1n01C2OkQesS19cdnVzy5koLZ/DJbP6ZMHiQCgjP0Gkb/G?=
 =?us-ascii?Q?NGp/coLWWY9QZuGwVpJcbnxxv9xVaiBj8P4+msaxWp43i9paJnEMaFDGpDTV?=
 =?us-ascii?Q?y1kqnoJQyPRKT4+trgiPhGMj5haNUJ1Z+wC61HrwuTIBPpWfVyvmUT0uioZL?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597ba56f-c731-4399-ffd9-08da59a0d1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 07:27:27.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/K55R3grlVN7kE6+t04p6dz8I6xSJZYv08HZdZMKkmLlu3DtxwUEs+F1U9YCczhlrGhjtWLSRLyRBg1KscyJwaccCokxWLNIX8Eve5+ivQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5978
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
