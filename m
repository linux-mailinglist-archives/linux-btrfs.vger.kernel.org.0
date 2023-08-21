Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBA782406
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjHUGwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHUGw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 02:52:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5976A9;
        Sun, 20 Aug 2023 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692600747; x=1724136747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XN+chh0i1lY1k5IWdwVRYJOCKcnuWIIBEgHNcSZJqEA=;
  b=nA0aYTaM8MCp1vjjoHP3kzy20vbshQsHBGIpSwYswueiwleq5/4LBuVQ
   iHslsbmAwjxKuKnkv6FPhZQqWrU3zgi4m3z1d1g9APvEFOQLPIFXL2Psx
   pDh8EZ45C34TYlhqWB+O3XGaw6/0qW9nvgwO+PKQtWuCmY7slZ8QZ72Er
   lY6ookXs9k5+WfyAaQyv924d9yatY/PVwP1bdLBrQUuh/xOaIyhlsirIU
   +tiwiIb1s6IzHnHBF/1Wzk1ZjbEUKejTWtHf6W01BKItFhbyp8oE9MG6j
   AUelo51Uoh3Z1lLXDlUrx1jaIDb/AIlYZ9N22jmrrgljeVnfjR7Rs9eL5
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="353643313"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 14:52:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfVGB12BU8vEvZyyiMeug9QZWL/p+/9wgj6quxw8/zsx7k/kbY5WWIrWAV4eCeLpjDsClnII8RO5Ew8AmU5kDRJU+9axKosyjTrRNXNIvJjSzm3OepPeTLx6ef5Z3sIZPJPd+4nTLc/8TnGuASqvEC9SbzsTZxFyDD1LBuk9UJ46BG3AVQGa5MKr6B42y2CtIo3i4Ewsd7RwbAAeeJpNIyUgHt2d3nvhCMsqkf486SNHToeRAbLRak8mqQdDn7y29NvoilgoSPVXWRgNgMWschYNnT0fWwTg+JLqr5g4tFCLXhLMfOvULKFCEtuOvRocplCo9kO0P/u1GPoEpvZATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN+chh0i1lY1k5IWdwVRYJOCKcnuWIIBEgHNcSZJqEA=;
 b=d/iBoPJU41gScePuG1rh/FUbl3LYu9mS+IpEGVMjbnYa+fapH0n1bALzIglRwZDNbJ50UxvJARrTsKLIW3Rvj4HBiUFoplHIM8oi5suzazdmXGnR0258SbemhleOORtAL3/tVOYdP6H5iRAew6+iMAtUCnm3gffJ8Qw8mNwNrsU3UdZAd1HcgJMkFm/s5/DTa+H92Pv3UQBWlq7kAx7sb4s4CcW9If+YlHhQw5h0/AMruVANcWsVYBt0rJbRVQ2GG/UsIKeJsLCWvPTsyBQ4nJeW0RSBGw5xGUqlMft7Fs5YD8jThdF5DzrEC1nFxLUEnq7D+UQ4DQDTbLXI6cMRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN+chh0i1lY1k5IWdwVRYJOCKcnuWIIBEgHNcSZJqEA=;
 b=O9SdNtDUTlpUc5jM+UigZywdoBG0pPPongLZdVB9+V4UtZPZnE9RY0+LcUqiXB6wesXtNamDf0ukaRkFe4r/lwpM6hLSo4UBHe1r30j6gbg1zGBotxEgiTXzNfRAzDMnIc6e13YKChz0n5fHGkYMzEwVHdBLGBsmX8g/xmMmsuQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7571.namprd04.prod.outlook.com (2603:10b6:303:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 06:52:22 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%7]) with mapi id 15.20.6723.013; Mon, 21 Aug 2023
 06:52:22 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] use shuf to choose a random file
Thread-Topic: [PATCH v2 0/3] use shuf to choose a random file
Thread-Index: AQHZ0/nsq/fOdI27xUa+U3/NJdAvyq/0UByA
Date:   Mon, 21 Aug 2023 06:52:22 +0000
Message-ID: <ckpdyq7k77zlmpqenic6lyagjodbp55f7n7tsionps7lupmdla@4w4adrcrho6i>
References: <cover.1692599767.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1692599767.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7571:EE_
x-ms-office365-filtering-correlation-id: 1fd76845-c66a-47b0-d6dc-08dba2132be3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ywl361Mh4IZda7/HA5HwJov7q5/DykZb3knVlpviqEK0Axgz2Xue9sCALxJHMEDB3ZA0TS33FgEztduhO9QlkZWAWNZWAGR4jm6F1xGqLQo4RKkUPsRZh0C/hPEJQRY4z5TdKnKMneRjxZ5i61doF9uGcZhaplk6IgXHV9Pmf3ybVu6qX8vht3iHBPC4K+8Gc0P+mwPAjWp46uyY09fzlED5+DXSUcaW5tBbUd9mlZ97fUnfcOfYSCg8B/3tn2oCjc4qQKX2cVkk0NBEiPG/pWQ4vhbHP/5O+uKZG10eKsNTxKthoTmi1/rNgJS4alqI26eNWLEb3QQfG6iUiN0bZvukUYsxvik/Wz+OYrxk+L55HeDiFFd6pDv1CxjWHQhVI8EXmSXvUXuHhUT3n5AksE4+J2o9kgIAIt6LkqvbShnFKzQtM49XkdrEtS7nqmHc7nBcxx+wb6+m4IH9Hl52y8mO9J+UNGp8NXh0Sc7yn9IHtlceTCAh6u5FS7wV8JORfT0UrjqjQ7TFcRxid7tlqhtfMBMjSMaMd4qMAbn80qtOpNOnQ4yoLW5z7CSYqpVVSheWmzalqLCMlQVlIMojCeC5uEoCapmukpLmPMPJ8CSjzQLx7Wggf6CDjnXxW86F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199024)(186009)(1800799009)(122000001)(316002)(91956017)(26005)(71200400001)(6506007)(9686003)(6486002)(6512007)(33716001)(4326008)(5660300002)(8936002)(8676002)(2906002)(4744005)(450100002)(41300700001)(76116006)(64756008)(66946007)(66446008)(66556008)(66476007)(478600001)(6916009)(38070700005)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RM8TPMsVdobCNasbTzyZeYcdEbzxhX3vRpJAnjpjAXdLSlIyg7XoJ1DSZJz6?=
 =?us-ascii?Q?caNU4PNCOdP0D6s7HtkSAWVgvTg1prVy/LqN87/kfIi98ZEo4UGCSn9G3ESy?=
 =?us-ascii?Q?Ic5sCDsosbKfDE4+YM8P7gG3KIS72d615Yi6PwraO78G2y5KBUOTWzq1foH/?=
 =?us-ascii?Q?8HL7EGm/6Sux+XU4BqbrSwipZ0mil7/8veUo0WXnJ5IL+Wyf3EQc4mOKjhuB?=
 =?us-ascii?Q?eRDxKlnSyvmviBNQRyZPBsakvMabtCuIPJtWrliCKll0pj8tZvZAiIG7s5r1?=
 =?us-ascii?Q?H5+iFnKPv9cB6WelzacwE0KutMa1+ckA3hZYhf/Q/5B1ajHNMB0qpAPSmU2C?=
 =?us-ascii?Q?NOFvguleN5zeWwW4qCbnCZRnPYKNxfuEl+PJoq7i0sX6R6roudv00wgTu+Va?=
 =?us-ascii?Q?JPzZZnMl6+l/pqAjb1edcFIdd94OTJcED1uKuQo+8y3VyVe19WMmpZYkyGB9?=
 =?us-ascii?Q?IhClqlwe6iny29NhC8A/dp17ucKf0n8tVD+vUP4aot2jy35XA9AOZSeOZase?=
 =?us-ascii?Q?cK9qKAmaKZvlcfdt4a6mi9O5a+frRuC226RvdhPDpMzIJjzPMbUOBxgN4kod?=
 =?us-ascii?Q?dC7oGdGY9UODB1g78lKnc77AjPCSvVYZgHKRB2eg7hnttkKHs+OqiDJmxdaa?=
 =?us-ascii?Q?2L7y1RtGJFJn5yo5W2fM20e2ZGormRwfcZdzUJpAnTJ5TZBi2hhugrltwsiZ?=
 =?us-ascii?Q?R+ITwsDYJK1gRrfYJeQagWWmtw2w+QYhtC5nA6RoPGj9ANNMJfTWNcXZWw/X?=
 =?us-ascii?Q?v2/F+XbQYuuLTQ/x/GSu4d7DvwZnGUmRpqGX7INfqHoi6mwNUtP2j01+/y3x?=
 =?us-ascii?Q?zOJNu26lAT/v8opxqGv3J8aJ9ty/XCoqtUTrGDbWwA3KpqpLoUOkN5kNBY6+?=
 =?us-ascii?Q?rY8sRzoqD9luIDMcv4ODgXhMCC/m+8PfutN7NhKEJPPAViSEA3VRYMKxdydJ?=
 =?us-ascii?Q?Ln1Es3iQ5RT0VcGXP8/x3qs/iUDKl9MFe6YFcxwnsJOZSTc55oYf41IrHEDX?=
 =?us-ascii?Q?/nbeJKCq0XGho1LYgFhdMsC+PVYULNV1Pa4R3J67n2pZXmRMwn47L6MhGryp?=
 =?us-ascii?Q?OoRyeJBafhQfOhG2bn0QrDysD8KYgafmTQtq4qZf/tRlo5UxSaPbvP66bvmv?=
 =?us-ascii?Q?wbZE1aqcArQ05gPGqI9to7vwd8dFwyHiQlhmsVG3E3HT6SM0bQoIWJwLm9PE?=
 =?us-ascii?Q?lc87+jePk91blJDeNsQ3c/uDtH3hL11oTSCnEu4zKMIFmtizm+O+I9EPmqRj?=
 =?us-ascii?Q?qeI4zVSvimf3fcQ8HQMj5vQGunHc1RZZRbIjNPJ4bcDg2UWu10ONZLr4DyRw?=
 =?us-ascii?Q?Enr24QREC+tLvExFRpubTXat3VNZ2WYXEPCCGtT5fI/HBOW8G8bM3nBxCdPx?=
 =?us-ascii?Q?ssAlhVBwgXMx3mNK6dN6mFFkdZAj7Hi8LPlDpYJ3U2ug7wKq21eQ1+x9mlqv?=
 =?us-ascii?Q?UMlA38Kc3t5VbmhzNIPTZRCZh+y4vDAaQyv8g7UNOJUVGGWYNSIdnXgVHSMn?=
 =?us-ascii?Q?U7OEBDwj3ZpQRBrC1FyZeM/jdpk+WkTX6jSGLWExpTZouk+uRKDZM5ps/598?=
 =?us-ascii?Q?ak4B4tGKtHnFk8MTmGKa0fHgij7gpkkRoxEor4OLLQWWV3gmZB9fCs+N83bI?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4453CB375C448641BE7DAB34C3A5E0FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uue0NMgC21AWWrNjoIkOr8YCCOhdeUapAOCPssffHFw5yS3juVyNlEBs5nQsOjgC6QknMw+UqL/ThD13MYfxDaoKPjMzgxMixAzuCxq//OcRYM+tZ61bAYAl+Eq7eSdoUq5vCF9u3RUw3HnbMEs4/jiyrO/DeKwOz+axBuB1hhiCWnWv1btqBT+ScN1JlZcMzVrgZdU2bsVZQ3VLd4jPgFh3tjDqZSdo5Ii4NqX+Ozuk27Vp8zk5kroH/x2korCPOGV2cthHl6nI1CH4xJFilzMbqywrjJTw3x2oEvlznNxAlrwedudEmdbhpCpNpq7PQgBRHJozRPErdz0NNNoGVfbH454MIuFnpVBOlYWTbWt7BUm7XmvV/PwtIkiC9zonAGIm26PIr0oCWkZlO1yEp4unS0ChG1UQZJ7OERcLIG8jcTNEGwOClmpH/HfLue73zTVnzl6Zm8Jgb0JY9QLkw+Y6EfB3VE/IMT8nKQgbBCmjvKSwZDOQlTHFnBdLGD/2bizHpf2y032v+xsmefWJaUaap2WHJCVQWtKVpVJ8xlaK/lHaAEStwXKyYkUZOhzqGNJOBodrt2sJY4q6sBi7vaqbeYnOy2ETwXhEReHdzPIdpvwe2xK9GVyGoYVg49ye3qwlV4WbBa7y7Ot/XfdYK9Y0Cnpqsf7VFslE7kxmu/osX+MtjNiwJHt3OTGDoEwrjw9ZmCRKL846mKoUXNC4JTXf7DzO1IZvp6hu8mCysf09bmLAj/tsJqCCm/FXaxXkbyBUnoXrHEEZxfAWJDNSgw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd76845-c66a-47b0-d6dc-08dba2132be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 06:52:22.7152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ielbn6DPwtaLIrEOMn8PrCg8X4aN7rHeF90KCiQwdT0xLO3/B1nRRQofaNggTcfFfnpJ/YGhBniuE7TRP2Ueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 21, 2023 at 03:37:01PM +0900, Naohiro Aota wrote:
> Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
> random file in a directory.It sorts the files with "ls", sort it randomly
> and pick the first line, which wastes the "ls" sort.
>=20
> Also, using "sort -R | head -n1" is inefficient. Furthermore, even withou=
t
> "head" or "tail", "shuf" is faster than "sort -R".
>=20
> This series introduces a new helper _random_file() to choose a file in a
> directory randomly. Also, replace "sort -R" with _random_file() or "shuf"=
.

Please discard this version. The _random_file() helper doesn't have the
base directory prefixed. So, the btrfs/192 didn't work well. I'll revise it
soon.=
