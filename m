Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CE572E29
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiGMGbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMGbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:31:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08D72EE9
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657693900; x=1689229900;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OmdBoBKFe5b8cSzixqyRcW8hlMvnCb0kJMdsUQED4O82vYy9uQrPOZ6o
   yPO3ZiCy46tUmsGLhi7PZH4kcvCLExSRkE1SuIlbruHpVRN5huE9DzyjC
   WURY6BVaKwh64CsCj38uqW3sQmxEhCOmkU//n+6WSGR0OP3cGB+o/rLHb
   zzEdAsoWI1i2Cckin4BPcAKpHdzQy/1pCXLek528ahITe7b+iSQvdeUBt
   IogdRy8Up2XTkz7K8wPiqcvZHdSYG8eVd0urz+x35OsG7J0riOwDv2+P3
   67QwXde1cyZzryLTOFXdHcdHEPuYj9N92rnHVFJAF4R777AUbNxcvvXMu
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="205575919"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:31:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmRdG7L7D452ftrxdDUsmNA3fSkUiPJypNmC6H7eRLkkm8v1DmPbU97clVHMtoJvHqL3V374ubnbMS+41haqJ8zYu14eIjC4icuZ+Uf01aB9lk+6DsIAed48infuRWO122A/u/mMNn0JZfhSIth5egS7rhsZDsdoC3y8V007zNbxIBAdNNSQf2spEmjbZZ7acGQjyMTkiEllRTrMRb2meWIHCRlqcd6ZRwhxgQ9k3v4uxiGbdqCvhcZu1jtNPLeI6pAyqGUPos58GgJjb9UKU1DDPtB8D0W5QECq/3fjqK/n/O6tB3BTw5rHxcmILR756r+bboz9Gd9qjgGLSGEB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QC3R9OJ53QNUQgcfh4MpHpE2PynZASeX+pQ+e1/CK10l5ysdP+4qSZ+eh/eKNHG/DcJZnbpO8RgS69SXNHo0tZ4/bBdeammFA4h0hu2l3bjqAZ9u5zsw4y05W8oYqp5p3KS/27B+ohFQCy/l3jWSxp30MC1cEZcbNlXHv6XS9GQfIbfCY41WQN6l0DVFj/mkZTB5mktW4wwY1rjQoCMbSBsoTB+sIc5WUpvMqzsdXiDIgzzR5HoAlCd3bqTZaXFSHtMezjT55/OaNE7xrrc2LqAb1ukz+Lm65GvYQFHcxtQHD2NFzULGWW7/OvwR6OLsiVOYywczaPkuEiB6jGMvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Rh3myS1lPXnoV873CfzxVt2V7q1vCPpUtpjYVbyz28MhDIzhyRziNJg7uF9vjilEtbM12AICEaLHGjBQH1ovZhOlIySrenlGF4fjgom1Bw0PuToY7ID756rrxZxu+zUHMBVHyNI5Q52QYYFdTtx64cTK55nX6Ou2SrXJ+mYSEnk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6033.namprd04.prod.outlook.com (2603:10b6:408:50::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 06:31:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:31:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Thread-Topic: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Thread-Index: AQHYln/J4vRfMX6mtUK3Ptb+nH5WAw==
Date:   Wed, 13 Jul 2022 06:31:38 +0000
Message-ID: <PH0PR04MB741614386524427A4E3727A69B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4337624-5867-4dc9-5808-08da64995763
x-ms-traffictypediagnostic: BN8PR04MB6033:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDADR9JrneaNiVnYRrxe5bztnJsyM5orVx3651ZSt6/wAoKKdxhUtwKectwF20vp+EaYOwv3QwimvRqfnVoSg1SEu29sWQ2nlZiY5tYlj1I072CJ04yjjasrwlh8kP9OoTe80ygiq6awksnM/wbsfxgfNjbH6bqQ76ZztJkcweezTqOS9IpoxG2ioFt5kaKeiduVvB6jibGYzLnx9yEtN24YSVsNsJzbhOa6PdANEfrpeiBPcIHwFsKmvzxSCiRrbYl6A6lLwyQj1q/WcGMWS+65MmzQllaCL+rSpEKQ7vjkzokwixgLE9A0XoxooHafQJfJchjJJ16fgFTiyx88o38mkOAql/rYvztnRke0CLMPg/MYuOG9v1QGblfhcbOI8HTVuEUBaAR7rBg7Q/5+3fGwXBddRN4fQLOJxZxWjQjndCoxzh20aQVTG/+lPA/CiZlYAZ4zRKgXbngKImY0b062c6prL8pTUTh1EkjI/zVuWj93jL1d2A2DKHKH3+JO483mVpsWtOHMzQQ1EhHfXBw6UIOqqeRKATH5ULkyGBqSy7onpUmpqLffRkr+L/qD0pAr/DXeyLzmCrfHcbpe9vbhHehUG0JzaPZVPRHZyHXaARBQpigtK2kTcBCOAS7UJgw0Lh/dg/sVgzH3uG+JQyo/ROr9ahrWdVN0o5GJi85n6dEWPDq6F+EJISCXex7p5b4MsU90USdr4rwJFimJOH9Kynndg4b+1zevdKlneCprUNu+8FMGrMP0T3Vhtn5cF54z6rAUjUY6wsavqkPZ99akpBkAKhjfg9H78jnqftv7Ih2oCwaHuwPBqdUsWMq9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(33656002)(8936002)(7696005)(52536014)(19618925003)(558084003)(2906002)(41300700001)(186003)(55016003)(478600001)(5660300002)(71200400001)(38070700005)(64756008)(6506007)(76116006)(54906003)(86362001)(110136005)(8676002)(9686003)(66946007)(91956017)(82960400001)(4326008)(122000001)(66446008)(4270600006)(38100700002)(316002)(66556008)(66476007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUsw92Bi+OPSwyf0fpaBT56H5eNjgB1b7iq6S/qfqL+p+i42t/+oe5eDr6DN?=
 =?us-ascii?Q?rX4hsUeT09V9N1a1uI5R80+Xm057B9geu7EAF38eHMMXkAiOpBoctY92XYj2?=
 =?us-ascii?Q?iAtafmFxO32au3duZiWDdE1qDJ0taG0+MlBJ+lkpUgLkt0gXYnLIfjgJKOE7?=
 =?us-ascii?Q?o+nLDIeSXw4TtgbirB/ShdZufFaAHqwhdKZXCfGHSB28RxHbo2qudSBzaF0B?=
 =?us-ascii?Q?T59Gg+P/kF5VjiES1kFCpNyXYGKr2vVBw1ITxXtgp3t4m/naI1cC+j3aMKgG?=
 =?us-ascii?Q?D7ZorHoUWzDGX3TsRK/N+aH8Edm6LW7btNtehaBjEvlabrLGfZoGsjaoVh3v?=
 =?us-ascii?Q?0kq9YcN1wQSCTnl+A/VhEwoEraX2dfrsUpMVd5cszHEyaTE5uWmBZUDS6rcF?=
 =?us-ascii?Q?Flc5ZPjTqqL7uPaHROJsuWsz9YQw7M4uRhc2/OW10n2LMQEyOE2JdTXZzgpP?=
 =?us-ascii?Q?+kMOUt61MWOVLu7JHF2zTvlRah0fp/Jq2/nBThtd37ua+8IOBn0ch5u2E0g+?=
 =?us-ascii?Q?yXyZMUtZwrKx2FQHMrGQqDXxb0WrN9hT9qNtsK8wjy+kwFqxwG7ckcKwxnoE?=
 =?us-ascii?Q?460BGD+HzlCm6xrRd4Zx4KE2RUIsbnpyds1pU0ERQP0Wp8Z9ufGebiSBKA5w?=
 =?us-ascii?Q?pTpEJ5JUOH3xFveiEXpbq7yoPjMRvYaRv8+OnsFwe9z3G3B1HAOcNyvQjyT6?=
 =?us-ascii?Q?COl0X+m5n//LKUu94uHwEL8IrsapqqdgO8GvCEbL+MYB+6BTskZe7mPUU9AC?=
 =?us-ascii?Q?RYmZqFlIPL/h0H8DPUApM0z5/S6iV9n8MjmJkvJyQ7ZolGSTrp4JDN7vVluD?=
 =?us-ascii?Q?9vc31MblCEC2I4KR+la/YFnAwF6XdxWuE7shi75h19jnxx9AodVCt7Uk6NTa?=
 =?us-ascii?Q?80zTHcmhgGiX9YgqOFY1GOT55z7VBEvAAx9HWW0E4GXU//Ut3rGa2bRG9tCO?=
 =?us-ascii?Q?/+H6dIf61xnCm6b7GpbH7JYP7TXdzWWMcK+2NNEYWkTNI+se5E88HQSjXuxE?=
 =?us-ascii?Q?kdQ0UNhL0EbnMSkVHWVVhnSXv6cEXEE21/zwBvznQZFwsRo4vdxVlh89K8sv?=
 =?us-ascii?Q?AitDrUFBTZY+6lc6YndsjFz2+Vf6i2SMu7/luoeMYaw6RZHMz/SqZhne+LDJ?=
 =?us-ascii?Q?CcrbMZm55mLew3pi9m/9ssDVz9O5VpdLDVivfB8GbAEBA7Plc3m6xJZ6flDW?=
 =?us-ascii?Q?udV+r7eTZxaK906rTBv+j6+hXOjJv/LsvOcR62/PdfUTGj0UV5uUYz8kEXpR?=
 =?us-ascii?Q?tsTb186/molWChegT+fQc83AK/ThqaDYOmkRbOpOdAr4eCwdpAZ3ZptY6OxY?=
 =?us-ascii?Q?mX42NgdElKYFM63oig+SRWzeXcKb2pg0GdxyzmkWl/l/tIGPqKTZxwqep61h?=
 =?us-ascii?Q?XiV4/OZsYRxtLzlla5mJFJTH7eaYmUNsUR/R06mYtl57JzqkMreMds4MTzFC?=
 =?us-ascii?Q?9/S0CChbXA2dmRQHaJUGu6OLPhf9jIqLiZqDdO4gUPbHlVV2ksmuop7L4XKJ?=
 =?us-ascii?Q?PUHgPrkzmLp0VHm8bapeg/QcChZjsmZZ86r3KhasgTcNofNOWtFUfAdRvEmh?=
 =?us-ascii?Q?vudPVKurxqR5U+WWa5LvBVg6+atJ/0onFc8wH5eC13Xlv7fehormBaspOcjj?=
 =?us-ascii?Q?lkmWOn4IAUtpeSNl0sDgILg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4337624-5867-4dc9-5808-08da64995763
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:31:38.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxIte+hsZBLvusNxhkvcglx3PehAiAvYpI+s5ucC5/9YvXEDDC8VjV0UsQDo/dnrWH5CRf3jzd5ZY6AA/2hBFV7wQteLIADHSuxQ+m93Lx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6033
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
