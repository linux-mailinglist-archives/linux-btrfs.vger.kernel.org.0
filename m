Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198952E7EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiETIof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiETIoe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 04:44:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8699CF45
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653036289; x=1684572289;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hKkqf4IPQRnjQq1pYRfmbH2Z8xaWjnfHy5tdGSDR37o=;
  b=qRye+lH5oTU9BvCUdt/XcrAh8P86f4b2u8MN9ylDMTGjI6nFJhWAp4dW
   ovyLj4jFnR3poH8nJaD7jMy0CR3w+SCztgbGQ0KmoprtB2H2kGE0n77+x
   5HRTk1LBfvgH7ZrPDbNCmuPIq6BHSskinWKOgaGailKyzyVjxj82n5H9k
   olpzjF904fWUQuJHfw6eb/r+NJxs4P2v9nUIa1EWcyRT4y//K2jri3CCq
   RKs8dVOS+ykPMgHRVjRv+a96EcHuks/kOQUqAexh0w+0aFeguhny6i/Td
   /D/9n8oC/+J2a03OQDfpmVvPMedf194KtpQ/aJsnhLlnPKOfVbAeBQR5X
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="201746459"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 16:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhrtrdFcCGj9siBt2r8xMHUnXONqMmWBC7BN3d0Zhj+Tg5a4Bq+l2eHldMHYEey7yVdS73Fbl4OLNcMhL0nUWd1NmHqQowt/umLxCOzd58GBrjhCyXQHhbdIfQbIXUgOCK4+6PiejYUPlmwyKi1rMowXQz7ziDG3+iLorzHA3wr9LZV49wy1ZhCIc9d8ctaSg7mlf+1IjpjfJxfYquOemkx3vSgjCMUWLrdCQu4BB4FBK1LZS1wJtmpOm0iSF2faednQUX4f8b6sEjMl702cNmw//Z9/UTmv9lab9e/luZO2SglcJrE1SZroqj7WJngxv6Ojceq3B69AZ8e9AvjrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO3q8x32b/LpAnTe757aCbbVcihgk/OTGDlSrw+KfLY=;
 b=jdYvPDy9tgfAWLCCxhDbxAqoy7wd6PhJDFG9In0ZwHM2sjh+ZZrVzwe8xDVoFf820pXxZLuAJjlJsJPdPqEgouhJo3XWyk8bk4qndGV3NFk9ZMEYNFfiPzvO/0D8rHemOY40P/i4a35jRco/X+od4yLCpejxYKKXEn8ts03mtmXukE9P1z0C1fFv7DIzBKUNtZRQPLwKBGvH1WL3aa1QIq+LRquUQVvR5KjMg1fk70MtZMOeKE+iZ3pbMJTTS4wG/eidISERweG3CzBffuNIHsS02fz0wCftrx32qLnRE1IUNbtslG2JFnL9YxSNyOvPeXCqr8Si9IiTvjJ5oAe/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO3q8x32b/LpAnTe757aCbbVcihgk/OTGDlSrw+KfLY=;
 b=UPX8oBvZdy8UDG6p9FSb/Fb2I9zR+yUB/0GCtq9EgduiIRtwsJD51OAprXMXNSCkw76Bbh3OyGPx+2ozd/0aa3sIcsfORYDb0OuWV96Om7o9J8Fz1foJSZ84UbjdZVGHq316ld84fgLViopak7qril0fHOjApSnB3zfhpl+RPy0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0480.namprd04.prod.outlook.com (2603:10b6:300:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 08:44:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:44:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: introduce inspect-internal map-logical
 command
Thread-Topic: [PATCH] btrfs-progs: introduce inspect-internal map-logical
 command
Thread-Index: AQHYbBqjUnmSUMomvESHeEi5FA9N/w==
Date:   Fri, 20 May 2022 08:44:29 +0000
Message-ID: <PH0PR04MB741624320E687C58D1CF5DB59BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <ff62eb10cbf38e53ac26f458644257f82daba47c.1653031397.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c3e6ad-1c84-4683-200e-08da3a3cf3e9
x-ms-traffictypediagnostic: MWHPR04MB0480:EE_
x-microsoft-antispam-prvs: <MWHPR04MB048058022D652F1E1239771D9BD39@MWHPR04MB0480.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Mmi5ubDvqJJ0VOZ4ZYExv5BGJL+hRt7dI/NkPagc5njbBFJ6LpHgPGoCDQJ5NqBqkeogbcRDazT9sKJ0NcShNfRKb6HeSp+nnHSPy3i32HQyT7/kcMRWn0OEpL6lNbXXFNyB1BLYEfcKYNgpn0BC/DwQ6wpS1M+v+B24IESzKUgPLlx0KzWj4g/qdPv+RRqcM3vCWRw1epluQ460/Z5Dwvgmlz9Vhyygwa58zK9JsZoVBqivN8jgZgSVVzcA+etBFfd0hvsW1sTy0wuEFRq5Au8Z0O0bGsomcfvgHnIhvpi8LQbIlxUlsQNrSPPsJEb08H0qi7o7YgWWXIvfxCOQ64w1DuCdpkKkPmn2+KbSgN/a68vDyTgW+0PV3eRUBySUpYuri5DERnZVWSR1biXNFVgYgnCVHvTggH0DQXcSy0dzN0n1V4C/3J47AK/FUQTf1LClz0ugGZBwVlljkPjffOC1UV/RaxXCA25zCdX6TQWUa7+w5gsTQ3Nzy6n61h5xFWOvj0X2zN30Y4NFZARzof1fEPFQDy8EanLho0x9xn8K1wTkqWbMG2iyC7qHR5vyEGwrHoJk1z46MTlsknW5lxYErptgsQB3+2YQzZh57117Ypfyi9//dv7WMQGfli1q5V8i68IEWVm9UbiJ1N59vmB2kVYm6PMhCOjp8CEt8Ra/Yk6UKfsIqTNDLCRzxEzzo4mcG3CWPFr2b0FBBou8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(186003)(91956017)(2906002)(122000001)(82960400001)(9686003)(53546011)(6506007)(5660300002)(4744005)(26005)(508600001)(33656002)(7696005)(55016003)(71200400001)(52536014)(86362001)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(110136005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6VayL0RX6MSAZN6E+Rh7nFfeVvobPfBcqRFWcqsjR35QT1ovrmBeLEEjFrwe?=
 =?us-ascii?Q?Y0VwSBBiGjxwCi2kO9wcmYZbsmTOPtxsUeaKbQUXwPLBG6mywLBO9dZXmxnN?=
 =?us-ascii?Q?6UES1IT0o0QxrG4ZFDKSKMAWCaulHdjiDk0uVkcvO4liW9jOzpETfZFFdWKp?=
 =?us-ascii?Q?FY4Ijh8J/jHF/XV8aCsnxaH2O3aqZuv2YttCSXaQl95iTRoaKa4vjmy7zQFT?=
 =?us-ascii?Q?UzerxBmVB0SK79cM4TQw95De/hJHfxm+6qryOY/5gDti/0NWvneHAk3Q2bV0?=
 =?us-ascii?Q?EtmxbaUPeljUu9rB9u4rn8rVnBqIJRHJ3smxKet3PbXQgfLO7uSSxfn0LcdF?=
 =?us-ascii?Q?Yr8J7zxfaz5uC+v6eKYw6e0bb2QPzdALf7O3NLwvI6/avIAKcWvT5/KZ8O/u?=
 =?us-ascii?Q?P7UAB+mdCuV6XlNzjYNbknNP3d3QrlkklFaIebEMt1e+/i8WkEAWfE7rj+fI?=
 =?us-ascii?Q?wROJlFBFlSFN569EjLoK54G6+ZS8q9Wfs9dYxZKwPumFHdnX+4fBclzuoyK1?=
 =?us-ascii?Q?9piKuB0HOTB1E6iMomiYoq2gBQ3iA6iT86YDmrQttyg3FvJ+VZ/2TVTs1oMH?=
 =?us-ascii?Q?0jyetMpQoOW5F8u47b8pTB+eRcYwHx6bT57+IOJx4OJeT0RUjvZJymislaqT?=
 =?us-ascii?Q?SJM3qRF8H3aVfajR5RAvSmEA0qdIwKGLLfwNslQ5zUFIYHEOchBe4r2jsQ+0?=
 =?us-ascii?Q?z6sgz9Y25qDC+maHwiEfcnIzYuFa3BLgAHZ2IZ/QlBWuvETzLVPkAIDLWT81?=
 =?us-ascii?Q?damN/g3VbjOfy3HbkKeEzjNSPD/kvEr3FZ3Z4vr8kbNH/9ZVCt/0UtyurF4F?=
 =?us-ascii?Q?KJ/cQu48WLXzD0InMA1q3Q3K6IabOBDjAKXshsuVu1oNsFSDdRUEPzalrRJN?=
 =?us-ascii?Q?Yvqvheti1fu+qAVADGBoSOl/8gVZUsp4/H1QrLUbYSd+kbtNZsIBzEW2vxuX?=
 =?us-ascii?Q?VtgNBAO+GQ5s+rLZK85xupiEbsLPJPEdWGdzO1QB4lMRmjtyLYpNjQqUQY9W?=
 =?us-ascii?Q?zX7VGE5ByxBpRUGRiHlItdtwx2P992a/+DYBZ08WhUNpMWAsaxl+NHmVH526?=
 =?us-ascii?Q?Wyhg6CjGgn0SEeJpOl67ndiYb/9GcK2kpKOFqKDp/3qybliaq9Uc2KUhVqQn?=
 =?us-ascii?Q?8Ze/ilbfTPhzmHn4977Icaq4vVAjIVIvT6u/Q5yT5zjpCCD4hJIHr4DK0qG0?=
 =?us-ascii?Q?rwFF4c5R8rh1cpSY/1hQKBSaX6yoCLqSMdE0NTgBtpJObprmw9AfUX8SKsxs?=
 =?us-ascii?Q?JDA932ikKGd0Ku/tEvm/BrQr5UryxOhjHx0tR3J/rsykcLGoSONYYqh7DCEy?=
 =?us-ascii?Q?8N6hsKYRdH7JGTVcq0b4o59cp4yOP4tkd+f/tv4wtvWY6u3Vi2rZrcdmrMs4?=
 =?us-ascii?Q?aG0pLUJ9qybzRcTVg0rXbyIgCsxPgzTmSyvc9Pwr5GQYPK8PM/WS1l3xhoXC?=
 =?us-ascii?Q?rBBiIsuF403Tub7w4EfuxnrleaCoWirdMGdHUaB/Rd+SXIBQVmCmkAfRPwQR?=
 =?us-ascii?Q?XLVdiR4/mUs4Eh5kgdb/sEUaQ6++UnOT5s3hS4sSVlJfoYNJ97qT7MRiD7P8?=
 =?us-ascii?Q?vfr1W4bYxNkHihsGG5nBYgsHQ/7X7EIMQ1WdEzsNrXNccnYmhxJhrrkEkRFr?=
 =?us-ascii?Q?vWunbLynUZ7ne7P4d6utnjMLaK2eBLfGxfk56xd88uDe8EHARl4iiG2A9WHq?=
 =?us-ascii?Q?/QAxwtGVDnBKrXQxXQS85CVe8BpkXNieB4XvDzMGkGFeGzXSkTqrF4QYqNyy?=
 =?us-ascii?Q?u6ksdDN+NKkJSxvwQ28OlKNP4xeeT2VULQ/RXPwQWpOlF2s2mpgt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c3e6ad-1c84-4683-200e-08da3a3cf3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 08:44:29.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRHLFYsq9QQgqorz/3zh3dGWWvfoam1esTnpz4QL0xa20V0P9lTsyNPFPVkD/zI06O6zMne8nBt+a0kT2lce5ufG8dL52or/B/cooyfo4Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0480
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2022 09:24, Qu Wenruo wrote:=0A=
[..]=0A=
>  =0A=
> +=0A=
Nit: stray newline=0A=
=0A=
>  static const char * const cmd_inspect_logical_resolve_usage[] =3D {=0A=
>  	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical> <=
path>",=0A=
>  	"Get file system paths for the given logical address",=0A=
> @@ -348,6 +350,81 @@ out:=0A=
>  }=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
