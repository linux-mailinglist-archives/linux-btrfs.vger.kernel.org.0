Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C50645E55
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLGQGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGQG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 11:06:29 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4788A4D5EA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670429186; x=1701965186;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=R6yzTlpZdhr/0dnvuGbzfcupKxcsvt96qYtcq18Tfe0Dk2IuLLhFrvaz
   kCbqTaWTdjpcyIjUO3LhXDOj1KZE+hDFQuBfBPmtm/HaRjg+CyuhEpe9Y
   n6lj7aEJ5NApYGS3N4q+ttA08FT74aShfBKGX0R1kuAcVwUvlurA4VPSp
   wwKntzsaRy2dVNrmD1vnJycPLLEqizZ46mvksNK6mo78wJ0fM4eLcg844
   YbLtE9KunAh7H7/mz1CZ1pne0w6VN5MM4UO/kvhoTHeWxCTYmxC6i94yL
   21laXEMz4oTTSFPCF+gmX/6pQrpJTsSrdtPs+NGsS+pNIMGss+x1570Te
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="330203411"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 00:06:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3xgwP9XI42S18E40ZQYI61eQKfvXqsbyrbzsZ2D/VA0ls+P4Dgw+QVaZVnred36ElPGCerig4U3IgSmGuxDOb0p9kvamMRd7BwtrQXy3+Z0ShXG7daSrXGmQSk4e6w10IYpkEj2PiPf/b4CoekEgXca1h3d/5teyudiIPbRaNdlWH+TQMbWoRgRU9ihfWq0tVfQnv3HKhSY9//szjgJR+gZsaQVMgUsee45rmuIORDECauTe2pGAMtj17PK5pfADm8Z4jtMX80tbffFJwDzC17fHC4+6k31WtAbhAcquLmwirJ4kEQmDlNM55RW41KsrtWU3SQ5ZWR80CrawNHbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Rs0FGgHye43osA/O8oR5tfJ5GImDA7f4xk8DbIjAqPiLIXhjLWPYZQs8Nxuu9JjTGU/StCy+IJJt0iHK2RBpsjeBI4lyMW34uLd+Xl4k8MkFn72TiSyScpK1nbrXE6r/8EE25mLTt9wL0lf+hvol7A6WMUaMbvhhcuy31iSaYzEl9kKo7yvkUZBiYwYi+vndZUhAMDOoz+VrAbQyNhVfGcYAZGQ4ONlpfJob8Ly5k3ajqQ6UyVJR11GgE6mSJWkwO4ypYweC2n31jQtRBwwGmvEjj2jDq6IWAT5RSrSba6yJbyZc1BAIMOLS2xlN/+i9SRPQcr8q+kUp6JK/0jNKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XsZrG8c+n8JwCPKxyH/eUIYannLa2AzC39RaPMp238s1cfNX2UhmV8WaHU3KvlfYdva0Mz8IakX+kYJfwTLu5gLeJQnoxiSaZ9umNdkqLF1wYyBD4pGfELGPrDkBPbPrAmfER/oOgi3W9FTgROWgJWX2L5Qe6VjeiXGjvjmO+y0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4425.namprd04.prod.outlook.com (2603:10b6:5:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:06:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:06:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: move btrfs_abort_transaction to transaction.c
Thread-Topic: [PATCH] btrfs: move btrfs_abort_transaction to transaction.c
Thread-Index: AQHZCk8q61BpVxdG2kKjqkfDlawurK5ilxQA
Date:   Wed, 7 Dec 2022 16:06:22 +0000
Message-ID: <3c399732-3527-0f74-2dcc-51b5419f1cb4@wdc.com>
References: <edc2981f978e80b1cd1e4196dcf4a109831a6354.1670426276.git.josef@toxicpanda.com>
In-Reply-To: <edc2981f978e80b1cd1e4196dcf4a109831a6354.1670426276.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: 1b003f3d-6aa8-43db-fa37-08dad86cfc30
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEL0I5AU+5p31UF87M0/oayH+AXtoABQXrLTvbfVF1xDELwLTVPYY4uX4/acgq5yJSiv16JbB1go8la7B0t6Sul8hXpVdOYFvmSq/SeXlqbcIyyEtou2sObBWqRTLePtmNgQZRi+yjvB3Tt5DBhMO4642BSI/61EQHHHO5HIy9/E75hRpSkvxNEpDz2Usy9JOvPYDZBoDIECdOph2EXZTBs6HJ40vv+KgH2NcW7ejGtYJ/9zCGgjDArUexpQC5jSZK9mpGcOUrNYFOVFiTrAC9O7aUA45OL5dlLA+FMIdw3gMr4biru2lv6156uPvSPlIaOgN5F4NBWm6YwpO9DzPkz1ndk1iD55YEIk8UGWfM2LqiSMiJiA9YnCtHwwl1dDC93dpKSfU6Zu9SNVLpi0gpfZ+YWHxPIDbLUuxBAlzF4rRdeFhZ+DKZlOxSHTwb+BuJAM8/zo9+PSsXu+tnYmzbwz1vQiAX7852KFLrfBKHZpU2PATfbgUrax/PHszNhcFPBfiJmUSuaKjo7FnmeMwB1fB36EL8rOvEeElN3osvPGHP/8nE5dSw9PYzaVPUHacgi/0WyNBq7YRTeis56mNX9gx7XPdT9Tkqq8wgSbaQLqsGndvtRRg81NWhR8Ncd3BaaFk2+whrEeRGSEeDYZ4++PDfYlWWnqO+go+fdNxPPHXaK11ClegYOTxk8OKmZG1d1JKmQLiZ5jkBWez9ekXLy+veCpV+VRb5YSmojQzYM6i9O0D2RSqKflz1Hwk/VuCDNSyxunAOk28hf3j0TexA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(316002)(41300700001)(110136005)(76116006)(558084003)(91956017)(86362001)(66946007)(66476007)(64756008)(66556008)(66446008)(82960400001)(8676002)(8936002)(5660300002)(36756003)(186003)(2616005)(122000001)(38100700002)(31696002)(71200400001)(6506007)(6486002)(4270600006)(6512007)(38070700005)(478600001)(19618925003)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2RGZXpFZEdxaXZ6ZmRteVprMTdBeTJqTXVSYlNNMlhtS2g1bHkrdnVCWlpp?=
 =?utf-8?B?c0FKakl6c2NJUlNyT09kTkQ0UStXbWhaTVk2QVYvNTBhUEllVWJad0RHTXBH?=
 =?utf-8?B?YjY0Z29xWWlSNURFcDNSczRiQ3V0Qi9FV2dQRmw5bVg3SVJpdWR1ejcrRXBs?=
 =?utf-8?B?dW9odTZVbklOUyt5QThXUFltQ2RzUkw5L3ZGcWE1N1ZRd0ZqR3ByNk9Zbm1n?=
 =?utf-8?B?Q0tvWTlqTFNVZDdnODQwRG01clA2SHp4V1JWeTIyMEQ3OEhyRzgwWGdVd2pm?=
 =?utf-8?B?dUt2VURrazMvc2FqcGsrcDg0MEYzWGtHcFEva0NsZHY3aFE4ZURIM09rNkR6?=
 =?utf-8?B?dG5nQk00MlFnUkZTem50ZlcwcytQZFpJNUtldzk1dHpNcS9UdFBSa2VyMkNM?=
 =?utf-8?B?LzdkNUpjQWZCUTdxa0ZLMXVwRnQvNVowa2lVV0dzT0t4ZUJGTXBMK2szRUky?=
 =?utf-8?B?alkva2Q5WUNZNUN3cFRxdTNscHFQUkplTlZmQXRTeXF1b09VNTc0cXpTdUNX?=
 =?utf-8?B?aVZOTmFMbEZhOGdFRmpEOTdQTkN3RDUwVEdJa1o0clJGZitEL1dHQU93SzUw?=
 =?utf-8?B?TjN5WVp6OC9aU3kzYVNWZlcxUHdTMTFqNnlaMG9VNE9jRXFsN0svZWx0YWJD?=
 =?utf-8?B?ZHZkaVorNnV1YXp1T0VwRU9mbWtxNzhMNzZTeUtwbWowTnpKcU9sbGVSYmxX?=
 =?utf-8?B?Z2RmdDNTV1FjVGpBb3VrOGs0MXpwTWpMQ25LeWs1c294c3VpZEp2SWlrd0pi?=
 =?utf-8?B?c3NINGRpTk1QYUc4eHJpOEdMY3RsSHpIbmJ1Tk84TVZibTFHVDlCQ3VHeFJT?=
 =?utf-8?B?MStUdzEvQko3UXN0MzZabmI2b0YvTTdBbjhUNEhTSHJxeUhkZklyODBsZHBB?=
 =?utf-8?B?N05VbFlDVDBXMVpHR2ZTRHpLTjRTM1VLNXAwRnUxbDlhREdjbWZadS9CS0g4?=
 =?utf-8?B?UFpNUG9DcG5rbnBScjExSnJycG5KVCt5SVgvTTUrVkZ2QVovRnJTZ0RIcm9v?=
 =?utf-8?B?Z3BwZno5UGJOdFUvZVMrTmJnb2dHS0tERmg5eHFXd1Z6TXlKRDV5RnNvQ3gr?=
 =?utf-8?B?RXBCUWpCVldTSURTWERaczEvanlCdC9RamV2elBMQ3Y0Z2pJNUhISUdGd1h0?=
 =?utf-8?B?MlJZbTVETUd3VmhIMHkvOFFwVWNEQzhxQlhkRnF3UVIwN2xQUzFuUGV4YXZa?=
 =?utf-8?B?OHh5ZjJZV2VBaWpFemY2Q3BMN2JSTkVnS1JQZ2hYbENSaDNDQnBTNnQ0dWlo?=
 =?utf-8?B?UlBHRHJxRTFwTExhT2hYc2lMN2xReGZienZmZ1NlUEwzWFFPWk1yZklDZGQ2?=
 =?utf-8?B?WWhyd1RwWC8zNUJxWTd3SGxZT2JqTzZtR1V0dlB1Mks1VFZPc1h0MmJOQ3lH?=
 =?utf-8?B?NVd0dWVhZEJGZ2psakV1WkhlMGExQVAzV0RKUDJlUEFMUzdpU0pMVW1HVGJI?=
 =?utf-8?B?RFpkcmdFNzJwckpBYnF3WTV5akQ4cWlLRWdIdUxydVMwVnQ1Z2FoNWFQV1JE?=
 =?utf-8?B?N3BaYk1DOXFmS0pvbXNEbXBxVCtBWGxXdHRra1JITDdHVmdCb25BWE94ZlR5?=
 =?utf-8?B?K0dkUTBpK29IK0dxTW10dTN6Z1VyY2JwM281ZjZiTGI3eGFIaUZUWS93UU1M?=
 =?utf-8?B?TjdCWTNmY1hzaFNTNG5JcldWWkxNd1Y0bmsvUS9OVWR4SjZSbG5zNlFjdmE0?=
 =?utf-8?B?aEtqUHRDRkFPQXNBWEgzMTlyMjRmWHJYcm1ObnZNMHoxekJPWFFRMVZMRzFN?=
 =?utf-8?B?d2pWd1BpMmZkZ09MeksvbDRUZktSNGtRZjZtSlFKaEJkUTczVUpzTU5SMzI0?=
 =?utf-8?B?SHFPU3dkRkxiTnNJazFmSk05RFYvR3BjbExTU2I4SG15VnRXa3NlYTg1ZkJR?=
 =?utf-8?B?aDlKUjdDYWdGandZK29HR2ZSUnFRWHFHMlR0NlRGNk5iVHZLbkYyMVpXVnNn?=
 =?utf-8?B?d1VyZE1YMm9namJPUmZyMExwTTNkN2tSREVpMkR0VXYyVUhWM0xPRC9YNmhG?=
 =?utf-8?B?NkpsUmNGQVVvMWxmUmdEK2ZDcFo2MXMrQitzYlIydTBvK0pVSGJYbVFFNlE3?=
 =?utf-8?B?aFdvdzFCd0p5WjNTOFRZa01oeFZ4cDJMOStZZHJ2MkZ3U2pRMHZsUWtCQktS?=
 =?utf-8?B?eVdraGZzSXVHUG95NEJoaFdDTTBZaHJsRXFvT29NaVRpU0ZwMWNEQkt6Sk5E?=
 =?utf-8?B?ZndjY2pLUmtpZkk3WGRPNnJyS3BISndDd2V5ZnJLeUZZbzY0aXU0MnZrUmxi?=
 =?utf-8?Q?2FOBRRakK84L3nQhsoV2X+sTJHcnkJa5RziiMQI3r4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA872BA3C807A47BA58BF1EF4118A8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b003f3d-6aa8-43db-fa37-08dad86cfc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 16:06:22.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjVefsa3Wwq/Rg703FRWXEMk++Vz34CfNON7e3sPPHU2nFtm3VSJ+6T0KtKw9Ym0h004tDntf3ASv/4KKiIAHq7EBQlsmccsG+10D9EvdF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4425
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
