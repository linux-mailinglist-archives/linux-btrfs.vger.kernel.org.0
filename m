Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECA5B9D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIOO1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOO1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:27:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DEEAE
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252037; x=1694788037;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Or/S+HoMUqH4JkjYeFORsF61VfJJkpougodagWbFXD4RylIAV1XWdqvt
   bj2viCTYF8WtG8OhH/XjDTQQMYYvXJrLAcHA5hx1H5XSV1eCw5tJR5nOF
   QHepuVruqn5EKQu3jgB7rWHpdKqyFUR2CyPutpJ+zTw1qKY6udAzW/xvT
   fKEhIi9URAou4HVrzM8Ir0WRMk0VzZc+yuea831uPft6b/D12WSuUVsSg
   axhc/aWd+t09GhNN9DT1ss2AokUGbkXl+oLbd/EjETafwqAV8z1u4MSVE
   cyV9yGxfw7M1eR7O7SkwcCN0r+0W+Z1cYAxWfKhba3+1aY+ESgZV+YT6B
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323544761"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:27:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM++XUZ6n24j+sflGicumplfYJFoWrgXSbKuf/VbzfKZRtGq3zc8qLYF6EgotLtd9kqUb0jw2puHmGato73dinIaGAGl+YJhw4hf6iuuZZAUojrzuIfLWkgDNYGvsoaIlfAPnAlLgxV+qVoh80LP3A+/dGg6H4k0HbfJCEFbge3ULu2SBX4+z532rzxyjDZmvNhPrwaKtSRjF8sQIZmRvB/govam+7+cQTtDGXuzWMwQ0lnbqlBkioqn8gcG3jbACozIz7jGyCGPcclTTCUB2W/eqkceLAPzD3Ag4YzkAzah2EIEkAGTdLqWQsqLWnR8a5Xl4EViACPXMqongQhEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VIu8+BvOP3JiGy2uv53tJd662wFLM31s6ccPaWxOmzwzZGqBt8WSWGhP1MQ+pSTtALxDV8dKJWNBJfRLC0sAV4XkxkMSDoGZO3LDhMlmg/kwa9Yku9QtyaIbyTuLV73MH1ttnVu0POUceiLTbNNiiBeODDdmAV9Fzrc4RBB9Us7m94pg44ixMYRjjHYxccJc20dtH6OH/epHTyEk00NlwGrvMNXY+vDlBQR6OxyIzgNFnsS7+AO2bA5vi0aCPWB6c1fyW9hyNJ2nQi0Pw87b36TRAU6dNL4WtmBasoCYUEmcqej2y/VZoFYuPAjpE/XOsde3DwDKPvMfmGFtWwi2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oGgizeL8wZikhrTbXbOEhr61NkOEiTQxzvQhzQPcKAp6DdiJvopGk2ggVwEU2ZHnLXGjfm/5vJ1fWWh0I4fqDsQM14fKySdskwcpB6nwfMjfAmzaVdDbF941P20rxynmgg8zbNufEuGyv0bT4lQ8gqW3BVZSUdwKT0m2GWNZ/Ws=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB1200.namprd04.prod.outlook.com (2603:10b6:300:75::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:27:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:27:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 14/17] btrfs: move btrfs_path_cachep out of ctree.h
Thread-Topic: [PATCH 14/17] btrfs: move btrfs_path_cachep out of ctree.h
Thread-Index: AQHYyEvBJ+E+qcU98Ey/HGzG06PVUA==
Date:   Thu, 15 Sep 2022 14:27:14 +0000
Message-ID: <PH0PR04MB7416C8A4D443BE01145E54AE9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <c52053467e423a650b9fd0edbf789d62fb7df87a.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB1200:EE_
x-ms-office365-filtering-correlation-id: 080dbdb8-ea3d-4152-7796-08da97266285
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oaTTxEPvvbK2Qb9W0+J1QEpdX5sbneznTVG2knyaHsDzl9Ffss8/e8D9pk6Ahx4slLFBqnll/GgR2ttECAOtjgAiq20oQ2dtVrn6L9I1MNuJyr2ME22EVdaqFZ3eY6GOv180qqj/csFBqp1B4CgGUPD2vokUoP9ThSkf94CARz2mRC+RVlNfGcLgF/091PoOR6lPG2Z7uyBGmxKg7coMhZKaXLS3L92KsLtxOUyLOJOYOek5RLaBm0bhsf1H8fdRuJzrtTrW+jAMHtvedZzsLudpo7DXLnF1RcovIqee9am88RJLW1EcKaO507jZt65JVvplxUkwNBzKXN9UwNOcBnichvMYv5VQ0f8mpLLbS+u8fi/WhwTG8tFLTitgiTFSMowU2lLharZ7oBkMP40/UlxN1xcegLFukS+QIQPsiq/dKN/dv0UsajsEDAHTNyd43zLbLM35w6gnESzpQ5BzS4goUxT72I7dYd6aV0Yz/GgLiiH9Xa00Rh8vVBDw4SBt8ckCwar61d2E2Yt4UTL/2qyg+YpQ9a4NLaU0XdE56c4d+6o49RGgLuZiMyJcFBuFwWZCYYS2ZBezpspIp2yjwkAx5fAGP4eC6Id1ywomg8rjTRtb/86Hv8FF7CNWPWVr5Kn1LK5gKZeCveAVYeS+70x6gn3wrbZfhv72PnGyAY11Wb0hm9MXmRnHgveZOyLnNkpwmMwlWiwihWvGHtvT+DoeGJTIzPQv9GBtQ5Ej6D47mHjKKGex84s0LQikVDFKrC7rOTh2Jrgjp60ITNqFnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(110136005)(316002)(478600001)(91956017)(71200400001)(2906002)(5660300002)(4270600006)(41300700001)(19618925003)(38100700002)(8936002)(82960400001)(9686003)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(6506007)(7696005)(52536014)(33656002)(55016003)(558084003)(86362001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTR0uw1GWLq7Abi7Z8ULjynAp/UCMESSH5casye9Gv8ASTG5W0jGhVJDh1yC?=
 =?us-ascii?Q?y9Es7reeeiR9fY6OhhANFfrkKuQxto+LoZMGT+tgcpveBFXB8zrfYp6AKZAd?=
 =?us-ascii?Q?QXoSCw5YByyXeVd82pURcuhZDH/zIRz3b62BO2ThRt8YqBIy9Fzlv90ljqFd?=
 =?us-ascii?Q?7K30uExIwf8eeC777nZ3UZ6G7stTYIFleRBBCnTgnBzqwFwQck+f4lYmpY4u?=
 =?us-ascii?Q?7beq5z1lRXKRtLpB4XXK+fuNdjIjz/7ch0ZqTL2TgIXVocbZycLfrZBIoGUP?=
 =?us-ascii?Q?JCEAUFI/Wo7x/BkkRAbJGDYrQzab1KWEjIUNnoayptqk1eSNMCK6QvL7BExJ?=
 =?us-ascii?Q?Ej3lqSU5/7Zb22dnAzL3xVplAglXN8tg+f+ppcj++SnWhCAh3qWx09kj/aUn?=
 =?us-ascii?Q?KSZ4XUAIBoR0L2lkRyKucPj0yh/GZf007lwIUc7dq4xUt4bYnlDetyHMxuRP?=
 =?us-ascii?Q?cvFoOvrv9bxzXfsxgs6iB43VM1JD2RKMQTVIUvE7SboiQonVbkOwkr5Sa+IX?=
 =?us-ascii?Q?KP1iYr4Tin2gh0KCTHrnkCDJVZlbdhO/Vw93UpS/+3WfsIEQMk1KcxETikaq?=
 =?us-ascii?Q?bFFKsmg/6RRs40QKiNaQwrq4VecDlnJXgkMQI3UmpMzvY3A6gQVwhyu3dbJo?=
 =?us-ascii?Q?8x46PXOEmN3emlkzy8Y+7gZzDsW72V1aFSQ4grkobe+NYkjGZxSEkQQuiZV/?=
 =?us-ascii?Q?uvPFUtiEWtD2RqRMrDA5Yo8tD/qfcLHi/4yr+Du4fktS3euhVDm9IdnpkEkm?=
 =?us-ascii?Q?FoBQ0CcidoQKID7uf52KtsvgJnMBjTQR7FCXdC8u0F9wYdzzpAI24RF1HSQi?=
 =?us-ascii?Q?JC4J7w9F1VlW806fSEQv1eb9ENgD5+DRG9g2UXzUscDfCT4mGYU3vh3F218J?=
 =?us-ascii?Q?wk/AOZf0Gz3OS8sxqmsqTM/2UGVDTvcvOklsMj/PZSFcgzh6U8aqAbhRfhaZ?=
 =?us-ascii?Q?bhFV1RZvjKRnOFAakG/SeYz48pDEPnUrkInLLyToLG2LIdqfmgCZN+soiI3U?=
 =?us-ascii?Q?jmXLHhF2yHfj0K38LhcZ7ZQI3+45G2kX+rIqJx6gHZDmEn42r7QJxkvEEjLn?=
 =?us-ascii?Q?ZlM983G9kG3drJXtwLJv0oQn4LL8TyMScYfo7hRUpGZReNnOetlxUMrjfXNR?=
 =?us-ascii?Q?1erDZBGKH+xGyfyeRzHbdIqBTT5VdxjKmRSM6eEpQODnV3NjG8WOYFQ2eQH3?=
 =?us-ascii?Q?s8YllgdUvZTYfQ5OByQgNVavItnlyfIcc5qEvW/GT3CRmXEHji/KnLGW7v+Y?=
 =?us-ascii?Q?x187xB8dmCKN2Bza0rcNxG2VV7CyUueMejOwh6VB1KsOUM8iDZDXccqSOAFQ?=
 =?us-ascii?Q?Fk+foRjqhWozEzpDkQQv2kxo/yBHt1pMhf4Wk5rvrTyVuTFILoSsBd/yPHM1?=
 =?us-ascii?Q?fjU40qpvjtTRtP9Qy7t4HAE4hx2oQ/kY01CQQuob3z5wrNKPN4nm0Yi0Oltv?=
 =?us-ascii?Q?iV01HEElB8vnKIW2VjcPBl43KpqiaETOkf1B3Y6bMBxNG6wT3FO8HjieotR0?=
 =?us-ascii?Q?PEiJX4Dlb5n65n/VrGST6Bfopz7PII6TOUEdWFJq4umjM4y+ucXjedBBnLGc?=
 =?us-ascii?Q?EmuQuQq02j3BNGXVAcQgBv8StlbGXodBaw7zvwAceMT+FOpq5vFojZZgddbJ?=
 =?us-ascii?Q?WCRjDoQ71nqOb/FR1sy74LrB9prug+tupzO2sdYF2TF75Ns5GQl8F7B2szLA?=
 =?us-ascii?Q?Sq828lKO8vyl3ePKVkIJDCFt83Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080dbdb8-ea3d-4152-7796-08da97266285
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:27:14.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjjQ+i4vQYSklIc5LsYTZplOAHxyb6kbDB3e7HI0w6I15rcPOeKldNg1mPHEn47DDBHtK8vPadVP6Cp7HOpAbvriMYJcUgDlt6ye+tHyDPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1200
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
