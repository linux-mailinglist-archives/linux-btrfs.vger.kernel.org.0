Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D517107A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjEYIfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjEYIfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:35:20 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918A186
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685003692; x=1716539692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=hsLZAk63Vma7a0qAQppEEhYLSrpIES8PLhrNH1SW8dSEKJz6k/flhJUO
   nrdVnCVnimRbR9P7VdiY6WtS5K/j6tw/nz7ec3CIHr7Mmn9XKCiOkQCQU
   wozMPs4PkSY+wAitTC27V2Ff7cklFcPly4x7zomaNSilTVNEndvG2EMXJ
   VTD3phUNVnGWzoiZkKAZTJPp4aOL18CBDm2lte+tApvZ9zIokf48lUAXE
   xYobuYuMO+KdX6vcNhlpwGMNbPGJrMd4Dsx2/jSkl0TuldRbShfneBNPS
   uDAEiEaS/Cl+73iBDi1EdmPpqIlrV1GCmEDoUojMbE+OWXq3g7aOq70oS
   A==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="231624144"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 16:33:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj357t1iQpIZ/FB0JwF/+lol9H1woQO8NX6apvPHPWlX66dX4qleJZJgFjVl41lvWbtVGtb5sHV1o/y1FEBd5x6sooAmb5N7yZm+qP+cZYZE9XlQm0EmAAhMNX1A1IZ7znbw0s1g1BnEx7X8+5x8XXWBXfaZmTmu+PYVTihQ9bc08BWQnCVhe6iqsOBt+brvHzb4u7hXZgB8lT/XAICb50nfbnV47W4o0Pqu+EE48GwMU82n9CgKQxqvbMZOcwJA0lBmgsbYqs6PC4bfQ3cAAIi5qYL4+xZRD4w0vUGKdzH3jMpKGUz1qgoX6AAkFaouXsGuFt7TOYGKAZdL3KPAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SN0TJK9/CEbLCs0B/7ojgI/yqqZSR/SDATkoTdO59/b5WPWRrxDlfoJYuOmYxVcbFFRfuiF2O2s5gJTDj/LJ8ACW5Lv75eQN/2l4jF8FjRUEKqqCCNTyRUYz5YW4xGKeDj90jAY2RUH1k/9dPMRUzjUEq3OuWZKEJBJDgNCRthlfslq7bwKF7bAltKa6iLoI7J9DK8+sFPolQgUWV7AQpEEW610t1MTnOQmtMgkIHpC+o5T0oI24zarNJ9r4Zv845MiwSlbiJxrdF+hZsd3zuTrsN0Q1m9f9el9lMlh/Uo8ne/GjyNA0D0Cc0tyAAFrodJH42WxmvhvUwjiknYViBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RAKfcjL5jqxfvUtnJot/yhu2ch7N5bj2kNsnk9v5H6T6u+s1XdgYf5dr3q7VPkegAQuz4DRcvvW6pinvRQ9NmpvsQ0nZBkC1FKJdiVbbSW7RqI3EnptbsKgnthGIB1pNDL/YGpFRkcJPFq9wiZOrH1akUE+IHO5yExa7DLVtWNs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:33:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:33:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/14] btrfs: don't call btrfs_record_physical_zoned for
 failed append
Thread-Topic: [PATCH 02/14] btrfs: don't call btrfs_record_physical_zoned for
 failed append
Thread-Index: AQHZjlDs17x8UdJ83kiY6JDCOXzHHa9qqnoA
Date:   Thu, 25 May 2023 08:33:18 +0000
Message-ID: <b84a376a-ad2d-c7ad-372a-a73c6175fb10@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-3-hch@lst.de>
In-Reply-To: <20230524150317.1767981-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7436:EE_
x-ms-office365-filtering-correlation-id: ac74bc3c-e82d-4d6a-b3f9-08db5cfab14b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u52MvwBruRZovqgWOVbuzs+8VTNvc7Z/BzCZ50ceCnJVsewbUL9L7g9li+pdbyYDUzS+2ceC70U7EOAeV5qAijatA6OiyNP8it3YeUESbXdQfLDaejUEs+oKiyAIjkRXRPLeAb99c9OLEH7bMOQOfU6oBg7VQ3tuIgFLwgpKAJcFbpVQxayWrpdEzT3byCcgNXt9kADnKF77DKWN94qsUVqIxF2AGEndw+5NYxTGnhYbblhKkOf+4qnL3opyrwDzdaRRjXbspqyFUq+9YGxBl9S1Jb3qzuhVwhttYf6uiHJjktNPeE9a/LjCjELU2B2NzpKmmWfAa6B/8aj51XKPsucKw/eMzIxnJKyZNdA/xOYVrQ0oIR1rM2NQLbY62Ebe52YLUNAk/euO66g9D2VBkdAbYWKX2wvYopECTfifZIZVkNW+sKxh1rkFueIiz+WPZrxzbx3wTsehPuw5KzJt6RfBHaOBo5AADrEPk9ulyjM0pK1IaGzb0G1oiP0GLB9YQIIaEuORaGKQa3IJrnmQKv1nFxs1KzEWkQwIVMBCVKBEx/StaOriVgyapka1T9f/eXRiV4fIOsfVFKSkAS7Lh00YKCnASLc4u84WISaNgQN5Wvua3bzegJ0B9/6Yb+5PUyORcxQSfC0YGh4JCLA5WKa8kMApk1Nf2tw2sYOCxAcS/tkmPfuPn24S0k4VOInc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(558084003)(38070700005)(86362001)(31696002)(38100700002)(122000001)(82960400001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(4326008)(71200400001)(64756008)(91956017)(66446008)(76116006)(66946007)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdVRStHVWJlZEFiWEdvdStXSDZ2Z2tpWjJBbGFzaTRHcmNYZGU4QjlOSWRW?=
 =?utf-8?B?V0t4emtOU29DNm1yT0FuQTk3d0l1Y1hOWHFFSnFoaHFjNnpFQnJxQTMrTVRH?=
 =?utf-8?B?ZmNDRUlRSnd4QUJmMjFzMXo5UG13YUIvM1VLTnQ5OWJBeHkzbGxOaFZGQTc3?=
 =?utf-8?B?Z0pWa1FxQVRUeWg4bHNmbExhZGdid1NqdEZ1Rm95VDdNMHJ6clJUZUc0Slhk?=
 =?utf-8?B?bWZOY05sc2RJQ2pSSjBxeFhHdWhkZEllM2hSMDB0VnVGdW90UjBIMVUrVlNj?=
 =?utf-8?B?Y3NlajZZZ28vVGduYkZLSWFTZXNrblUvK0hXTUdIZnRaYXBCQW1TMi9nRUlE?=
 =?utf-8?B?bnNUVU5zRU9RcWtUNVdWSWYvOVRDVC9yWkd2QzdaVHdyei9uUVJoR2o0bTJr?=
 =?utf-8?B?S1FLZzlsV2ZJUm5KOXk3YlJidXRPczlWVkpjR1NraFNXU0NIUHZxUDRSZnRH?=
 =?utf-8?B?QmpLNXZHeURJSlc1cFB0bEFFUXVtQ2M4MENWbHZ1MzgwU3NpWDllSXhUWFZm?=
 =?utf-8?B?eVBXL3RHQzBDU09SOWpyQXk0VVVDMmVjeFU5cDNJK0xjU0kxS216dmZJS3Nx?=
 =?utf-8?B?TXFQaFlNS1EvVGZVbk8ram9kTmN0cnVDbGhiUWJ1UU9BZUpWVEorRnBEcEZv?=
 =?utf-8?B?dXBuMmtueUFoOUJNSzFFdXlibGFNcFMwMk5PMFBSclorTXJYb3ZsK2hkcWxs?=
 =?utf-8?B?bXdoWlVDQVdVQVRVZHlCalpxQko1TjlENlZqeTU0K3J3Mmxjd2NDWWtoYk9P?=
 =?utf-8?B?bmdlVkh0RHFFT2VHbHNUZEZhRWRzWkcwNUZVVVQ1bzUzMURYajgvaGt4U1Fl?=
 =?utf-8?B?em9vS2xXL3hnbkhJay90bXBBVjdaMlB4TFNTeUpHZU9hcjRtODFPbzZTUHJ0?=
 =?utf-8?B?aXNvL1oxUURtYm5uMWdxUnYyTU1EVjhsMUFhN0lHUWdFelJGWUF1YlFFUkE1?=
 =?utf-8?B?VlpjWS9GSVEvcnRUdThJcjNPamp2Rk1nUXF0UHJFUHZhdTByZThlaVNDOWZ1?=
 =?utf-8?B?RGd1WVFENGJPdUMweGZkQmlJeTNod3h3MHJmK3FTQlJCYWVrYUdZc00yM29h?=
 =?utf-8?B?enZzOGE4a1puREJsT2hQcTlLREdRQWZDR0dZNXFKc1B1ejlDUFBTOWhTbjdx?=
 =?utf-8?B?Q1NaVys2TXNXckQvSmtTK2lCWHo2M2ZxVkpNa3dzRkpJc2xwcDVoRGFpN1Zk?=
 =?utf-8?B?R21aUEFRMXJUY21GZ3JWUUJMdjhvTUdJdkRVZjhMamtXaDdvRnc5cStzU2ov?=
 =?utf-8?B?Mm9mb09rSGFtV21hSGpkY0VQekdERzJEL25tUDk4ZHMyb2NwSUZkWjBxM1ov?=
 =?utf-8?B?emFNRzB2UUYrbHI5RUowYXY3bktWbE8yWTNoU3phRUJrbllTTzZvRVplZXRn?=
 =?utf-8?B?Vm1jdDhlbFJJQ2NVMndXQW4wdHJPTnBmK2pxdHJSU1dJUU5aZ0ZMMmxndEhy?=
 =?utf-8?B?UFNNUjBTQ2dzcHkydWQrVWhWblJqMWRVM2IvcUhQL2xFblAvSkhJUkhoWkJL?=
 =?utf-8?B?dStiNGg5czF5SVVDR1hMQjRnQkpqc2YrSENrdW5WcmR2c2hQWnVYNFAvL2Iz?=
 =?utf-8?B?RE9jU1BVNmhNcnRITzQyVVpGVnNPMDlHck52ZEtFZkRmRTA3TDAzUmMvTzh0?=
 =?utf-8?B?cFcyZ3JvSCtVYi9HT29ZYWEwT1RESW95cnJXTlJMZG9qWEQ0emJ3NFRwdWNO?=
 =?utf-8?B?UkxCS2puY1FLSXJQZ05hbHBId0FCWmRlL3RxbDBGSnZFbjUzaSt3dTIyeThZ?=
 =?utf-8?B?akVwQTBPZTZuK01sZlR1VDhjZjF4aldwbmlxTmlubEdiZVBOZ3BiZnBqVWRh?=
 =?utf-8?B?YU1tTldRQmc0WnlwNVoxdGI0Nll6V2Z4OUxSaEZRdnBzTWg0M2lXV2pEZEZJ?=
 =?utf-8?B?cDJYZ1ExempVZVZZN3MzTXNGVmE4WmNVWHhvNHZyMmJzOENaSlVvWlQrc1Ji?=
 =?utf-8?B?NHFNUGU0SzJ2VnlhNG1rK2lNbEd0b0xaWGJFM1krY0tMU0h5K2VWVWNac3ZE?=
 =?utf-8?B?S0JkRndlaWdpd241RnRQS01kTFB0c2dKcHVMTmVtdUt3YUdRbExCVnRISGdy?=
 =?utf-8?B?a3hsc2MzZG0veVZENVpmYlkrQjk1YXJFRENMQW0rTks1cURvQysyeVRlaUZP?=
 =?utf-8?B?NjY4Uk1qZVhkbmJ0dStrakVlaklaTkkvQXFZMHpTLzVyRUdIN2llYUFtdVY0?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D032444429AB6D4EB0EB0F8982697CF8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QD379JXLXXogsn1drsuB04TS/bWVsbFS13YcdhwR54mQ5Ki1DYTiBRELy+Y/qWqDaEggD1jHLRv2cnLbyKMUZ6kaBpaiJiMoQuVujQvctCZuHZscNI4ox8Qgx2/3ODnKeg3BIUR6cUIeWsjrsteQvXuS1a514D7ea8BRvsORJuWNfx6vM0CpB2tiFPtW6Gvi90ON/gUkfcw+gmx8EvJHbM466c5f/ln+zVqYfUtZXViO+8/JhpPuQEo061rxThzKdYPRJjyKYR2E1ZXdzbb+H88un1mYHaK9VisnkoSumHrWbC5iL0Pi2FlDbBLIsRlT16ApzMJmApV/gLCBcxETp3mDvgYb8KIwnpPTdgcSxn8CMRfXG69/6znXtNTX1Oy7g5OYBttYnymhO2AZ0pHdizYzhH73YYVs7IxTi6gKp10qoQf1kegoyfK2JkoM6l6w7J5cV14JeHIpF169OH4Vhwru5hsDEGh5X0Egnjl14XkkhRmtBPZRHhRiliLWV2bBiYjyvbZkFyDqDdlkZ/k0XxzK0hcAXpmyPWJpZJdQy2+/IMWLvKVi9pnXnrjQmOeWp2BYsQMXZU6MkWbyLPi3GLQBd+87JcZt9/INipw6BYTRPIraoQbiD5RZyM8i2dLK7XTrTV9JM9Ekh5KvTp/PTEpemYcRSAtCoytp7nhSJHBN0adc8UIPSRNxz6sSZFGzgBDrzHhlrlxaFglCXjNoDqtrgdzVRJTEJjryEgbpQvRpE/f0xzp8XOFVIZe64JOq5bUwsisk+VmYo0ugiIOE7DLwaxCjixlgkQzjzj+YPiWmdFvpeFWrXfCXZ1xRTuMVCaafDJMLZlDciUSKiFEV6yxCTMUKzqQSNs3Nv1YaPmlXmkQB2QU7zarB38f4U7oY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac74bc3c-e82d-4d6a-b3f9-08db5cfab14b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:33:18.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGpqbg+jbOxbvpkWV4wvsNNdmgxO3MjNY0T6WbtvKWb7sMG5+o+14wVQD0hXYMZSeX67sTeP1KQlBgAbsPatmHNHhG/A2pw0ekOCt9DOi5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
