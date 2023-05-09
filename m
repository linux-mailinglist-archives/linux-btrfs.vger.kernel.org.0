Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1C6FBBEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjEIATy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjEIATx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:19:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C440FD
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591592; x=1715127592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HLwnAe3Ssa9a5Dpe9aldGWKhlRc1vaupKbfPWr6B/FW+R+jSN3YR5KuA
   sCv9rSaCIzkTplBUPRfZiy/pIgM3lqwezVfTPRt9zbQ8mC53wzz9tEAJP
   Zj6srd8xsA6Yyo620dfRpO89EvCay/DOmCh/tBtq+MHyCe/xWtNnBv5ha
   4xjWpv8EHYkbOCJYhk7d6634XSJnj+hfh5TXMwNY1IXOT2rZJT55GVkPL
   xGmHw4I/6jVS4IS7EDD1Z6OL+FrfuqZqF0k3u5+3Hnk1gO3Gs0qYzvCsy
   o/5qn88o+PcS1XClN9ZHrsghn3FOEktti1Z8iVVQRfHVQ4/Fmb27pbILG
   A==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230080818"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:19:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVTeXD/ifhokBq3QqpF44Gy/15fmsqa+WBvrJwJLeOxmM/BcONDjmgAumgJapsLvmhjgNA/jbb4wAQMXZ+NY0PGyU53gI+GbK88DJ9O0KSSKmQpb1nupgA70ZvsMd8oAyQmdi+2ZfsEmPkeDWQUGIuqlvipuj3hXffd74XxoLixSrQOQsoJQ/dj5INSJxTv2sNhEvSEhX3hcHut/VEPaUDQW0daAw86Z2SI9u9uSgi1ruUvFEi7fu//eTmsCpM5HC7en3cVDeCnjqSuw878ueXxfvIHkn9KzD26Y5PUJmEZvhrCho2WCa49NeResMpbbtHqLKlw581COdml7IvfPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k3C44oCEWcjgFrtjHBA0YbRNyeQ2+Ipw1z5TBWSX9LuQkXNU1LyGSKJXoHR4wif3Z+gM33p2Qevx8+PRM3JSyGnspe03yw4Bc0YvSFSFjM8OdNdZllgKBBcSfsX8AVxELCmXWqqAA2Cq1z/lcyAknhrHyoHU+m1LIIj1jufxscywUPTM8RXlN0/Fpsuab3KgI/B9U9YGzbEw715mVQ6uW/IwmuV8RyebOIV1tCqK9rQpZk6SP5xGdvjpmwVUWONBZuBTt6e90CEnWMAwQNvQwEuLLKLdL6Fm5R//PfFelwpjzRczOBdiBPc084oPxGRzYJupYBvDx+JjdnLtchrXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=zKt/8KJ7VDZYE+ED7++KJC2LTgTKJV7tDDRPIl09uplfgDVYEmBX0P4lAelcNLvyTiMHqX3j3juuHb5wa5fKFrmky5P+7E1Zy/KCA2dIeyz41D7EQhxfb7p5EUM7GG7MVKwCwNj8w2+e/DcdmYexZXu1kZRrd2h329ETcnUms10=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:19:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:19:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 16/21] btrfs: factor out a btrfs_queue_ordered_fn helper
Thread-Topic: [PATCH 16/21] btrfs: factor out a btrfs_queue_ordered_fn helper
Thread-Index: AQHZgceFlT6m1GwlJkW8Rbg3e/N25q9RFF2A
Date:   Tue, 9 May 2023 00:19:47 +0000
Message-ID: <6138fbbc-6618-14a0-cbcb-9dc0a1c2b73f@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-17-hch@lst.de>
In-Reply-To: <20230508160843.133013-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7477:EE_
x-ms-office365-filtering-correlation-id: 6892384d-2641-46a2-a90d-08db50231921
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jpGY0vocdwhR12d1xgc3yC4lmesucPYFEYz/UKDDq7QasAECJecjJPlwFI2O3oRA6RAPYoB6FrLspZX8cSHS4bUEcwFac4TjU8cYXUI25SyGA0aUSZyPG/uz6AzCYUTPz+JveLzPMHkEZqIsjf30b+hq6l6xvHtlhbIlGJZpPbj4lnLN4LKj8ITfXF5CWlYg+8rNONkd3QnWbrlRQWjXBWHxZncvtG/r7zovt9p3XYa8SyBN2S9WMq8tAX95qFPcSHzaVYC5y4SkSGbQIvjIv8qWz0GC8FqhGcL5RsSzcZIK3A0Pizjc/6R5qLQRa8ttxT9pPn3Hez7cx8CBbDljBTyK59CJr4eM6JWFBM22w1yAezFmJHiMc6deahv3qodeeIylVbZhiYasJs0AGyh/EoqXYE8XaUUF03MUVnTq9px/10G7O/5zaSUoSwvdk7+PaPwfuwFjpMtXtS+JJwjl5JoHGQi7Ko3kAwqF4deN+uCyeixbQlEMQgvQA3+IQh4MqNloTlzjaXchnHNmmgVnzYSuSsTX5DBWLXEfjvHbTp01lDICUZpzPxlxjQsL2ZTuKfldGWn/wAGIPuwmiJjPO/sQEC6U6CjOKJ1oWXlxr8CBYxZNpMZj+wl4020yOYy6cSMcXTBmkhdy3l9q5WcIZjkpqrZQQmgxBZMrBqFYQaQTmOaXw0QnIKDi691GXOJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(316002)(66446008)(86362001)(558084003)(36756003)(31696002)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(19618925003)(82960400001)(38070700005)(186003)(4270600006)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERrVGcyTmlzNXNlS2MxVWp4NEtSc3ZFMFRGdW9Semlrd0hBUXUyNWVlQ282?=
 =?utf-8?B?R0xvRjdmdEUxaW4vc3h4OUlWeGtCdWluTlRrNk44ZUQxNENVYXNYbGErYXEx?=
 =?utf-8?B?Tk15d3oyUVJZQUlVZEhISkpvbHl5cUtLSGNPYWdtYkdpbDBrRmRRNE1NNXBi?=
 =?utf-8?B?Q1Qvdk9Gb0RlNC9MZlZ2c0tXMWJ0VW1zZmdKRWVFT2pYb3lydld6SVB5WG00?=
 =?utf-8?B?Z3hvbzJjbjNYc0FkZTNpU3BVcW8rcFNUY1RMdi9ramhqMG01bmY1ckNBLysy?=
 =?utf-8?B?TlRlb2xZNkk1OHpEb1lHWldhMjBYazFCc2cyQlZFeWEwVXA5MDJaNEdKTW1X?=
 =?utf-8?B?RmVGU2FZMjJWTWJmdkVOK0g3SlBvcFJvU0tmQ1NFL0tINWhhalFiaTlPUUg4?=
 =?utf-8?B?RlBJUFkycm1jT2RXYWtSOGttWCtRMzdkZzFKWkcvQjJMNVpUYUpvUTlGZXI2?=
 =?utf-8?B?T1FDeUxqMldpQlNZSDdPSmJoc09ZZ2JtRGtYVUlMV0pqKzM0TmRHdks1eEFo?=
 =?utf-8?B?T0xXbWtIZUlES0EvQ3kzTmF3SGsvNi9oYTd0T0NzSE9WQ3FxdkU2ak9sNlhM?=
 =?utf-8?B?b1hZbURVQ0N3VDNwaW5oS2l5Sm5SSnE1QW11Z2U0aXF5eExVVDZrdzE2bkhW?=
 =?utf-8?B?ZWJCVHFYWFpTL1h4ZkRqRTdwY3l5WjB2R3FvVWpJTktHWHJib3FJdncrZWs5?=
 =?utf-8?B?S0ZYR2tGVVZobjBnSVE3VTNmMlRZWVZpcjNPL29hZTc4aTI0NHF4R2hnWlVz?=
 =?utf-8?B?MUxnUkZOdlBiUzJiMjRmcUR0dEY0SWY4UVd5MnNLbjBuK0xMV2c4bDRHcnZx?=
 =?utf-8?B?d0FEeG9zS21ldHM0UGpDeHpjSlVOT2s4Z2xjL3k3QVd1QVUyTXhlS2dQNmdO?=
 =?utf-8?B?L3BQR0puTk05TllpeldZd1E2cE50K2s5OEQ0TWoxV094YUJGWkc4WjdHUjFu?=
 =?utf-8?B?RnlFbUwrWDhyaEJmZHM5dVVJbmlWZ0RNQXRpVlZ1NEdMc3VnRjkyZ3YzUFkr?=
 =?utf-8?B?Rlh6S215ZzNqcXA0NzQ1ck9mbWJoSG9sL0JYQ3lWdXhzR2ZIRi8rQWVZZi9v?=
 =?utf-8?B?cjZoRmV4WHhBRDYvTWwwejlYcG5oNmZXSExWUkt5UGlrRW1jMTBiU2lqMUQ2?=
 =?utf-8?B?WVIyRjhINmIvVVNkUXkycC9nYWkzYUNreitIZTYxa09kUldFMVQyMVBWajRD?=
 =?utf-8?B?cmk3NktqU2hDbFpHMWZPNHQ0QUY0TVl1WlFYdUN1VnVsc2tzbGVqM2lNRHEv?=
 =?utf-8?B?WElaVEpFUTNVbHNBR1lYSkZQaXRsNXp4eFlvd09BRDFmYm03NEs5WmErTDNa?=
 =?utf-8?B?RC8reHRQc0V5SVdNM1ZQMmpFUjZpNEFydjJVSDlKOGcxK0F2R1R6Nks5Q2xm?=
 =?utf-8?B?aGppcVV1WDBTc3NhR0NlUE1iWlJPQVBZaUZoYmhtbmNlSFBYeVEyZStkQy9z?=
 =?utf-8?B?NE1iZS9SZG0rdlBMK3FQSlJROGwxd3ZENnk5eGM0T20xKzZSWHZtWE91U1Az?=
 =?utf-8?B?QUVPamxWdnNxbEpyYm82Y0l0ZUZSNEhUZDZIaWhiZjMvY3NpNC9tNlJwRVl5?=
 =?utf-8?B?U0FrbTdVTEw2VHF2bUtGaXk0eVBOVzExRHdKSDhFd0RLSXlaR2dvMW9CdEJ0?=
 =?utf-8?B?V29JSldLUXR5YjFkNk1mbXhIU1gxb2xtdHJOU2szcUFwRklaNWxneFhvbHZa?=
 =?utf-8?B?cnNSdC9BRkd4WnBQVWVoUVpRQVcvWlNiUlNwY2ZMdk0xWlFsb1NLdGxWYVli?=
 =?utf-8?B?L2NqVkVQUHpWNGpJN3RUODI3N1RsaXFnclhwN05CYUE4WEE2ZGJyUnpxc2kw?=
 =?utf-8?B?NDQ1alp2N3JOSVAvcEVaUW41RCsvak9ZQVViT3daSnRCSG1JV3YxajZtc1ZS?=
 =?utf-8?B?a1IrOHp5amxrZzhkY21EMkN2MkRjVW1NcVZPTDNCaG1XUkxHR3dZenJpdjIz?=
 =?utf-8?B?Q1FkUC9OdElpRkR3NExZYVNBYlFmMVBWSW5FcHVmZEdlR0dPMjhheUxWdHFO?=
 =?utf-8?B?R1BKcnpZS0srcmJRRktqb1E4VmJBMWV4aE5zUkdnSjdaNGViM0Y5MlQ5VEly?=
 =?utf-8?B?NU83M2hISjVOcUdpaTFERDhrMnFaR29rSGlXSG80YnpBYWNoTkZCNGkxdFB1?=
 =?utf-8?B?S08zMjlFYXZiSTZXMUhJN1luN0o4cVc2S01ObWNTLzRyYzNCeXN4b1FMMDZK?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61FBA6784DCD8A43A6A852A4D94ED2EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QiivJvAzSogd2EUghH3ykSa4QZEckWrwVWkOxVkUUp/ZIKmlrkKVgfNsjo8xeGhmW0hd7xOsv4za/9bnPGiWM1czYM0+SUlE0nnoFpjRYY1qb9o5Lq9QGSvDPg3AdP9H7hhXI/SJD2ijs0/axKHXxQvW1wzRFBvD/Tuf1tg+OncZFmh2s0PuWt7hNIyAOGclCP9MHYJlHcIuq/iQKwIISX2KmJRDKWfXo9uR3pZIiGAvHgTWrbOu9+hLlF+x6Vu+x6PiGikBSCDhFbK3hsaLFIiWkEflR9H5vPwlHVVpPcWsjlW4sVHybpDw4z4MPuYh8TwxwIKe4+nBxxoUxdR5QSQChjMeR72yYKm6uD1LpULPTq5RbehdYi99B2powhcQYQiElPZnZXxZ4Dw/BAvIx1gj2JmoIlmktxCzDR25qSulguwtpUN1bjbiHXGTeJl6hORRDakOOW2QzPistjMQnMoZ5UIOlbdm9ASyJll+5mtLh5b1pvWvEIZPcDQxMIO913lBT4daCfl6VGhFLcBxqZ4CbcOb7H6RYKU69o6wGWYAGW31niAy+lA6/9e2WhWJdvbck2SZgjntr3s9p2oLaBOCKPnFdBJ4UAjXpY+Uw6q9elzKVThykupdzTCDZz6EUNXHDEVtPIpOjC6KRJCuoY5/yLe2rjOxWbmLn2adUD6tlDIG+tbu/mNgw19QMDkOsJtUV3lZlQuIjGUGG80H0vNwHWWvMOuX7ux+byeV6wzglOdKUZhfuMWiFYB5CqHBxKETEDV9YDq081c6XcNvM2boAAjTGkHIXrXU/9ZtHz11NLuiLcDREs0xOHujU/z+HrpsqDjZ269B3ZYNx+Gkk32610UFq0/J0VT2luKeTyM7wf6hNyBATa5VvvgXc89R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6892384d-2641-46a2-a90d-08db50231921
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:19:47.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTijHxOClyipiY2eY2YaGjt0NtZuZVfpkWB8OLylv95gUm3g9/3yvWIizyyh/sp5iVzPA5TlmqiGMK6JODRs/qgTvIRtim/ErzzoRpyoTDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
