Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234546A830B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCBNAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCBNAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:00:17 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81114996
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677762016; x=1709298016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ozF97fLSs8/0srHFyYa+BpvvdLIpRVAkk8r6iRjv3LDU2JGgZosLCQ+f
   +TPM8CCk3rCeiHOssYxReAXWrVc+HwmltoI6PD+Z7t2DdqxAPAQBTmF/z
   +kY3LORV4nvosaUdql3QgAW8rt4DYFHUf4m3WF+m+Ez+vrQD5fyAvq1uF
   dyqt3gbWQhdKEcUqKouULDdLhkHye310AMnURWdwBOdHeRvn50OY9dUxh
   l+l2c+9/N0woQFDiGlc5xIWzbKtn98wOjcdY73TpMfCtp5zAxnIcmRYCP
   1GTVynhMvSmrjDbkg4oWOVoLiFXLkqEDETrOtdHqSUoSpDFUguT/wFyOq
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328953879"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 21:00:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbsAsTSh3T06ZuFoX499eBxwerJ7MoLtPBiu3HHfT/d8M3WHELtjdhycW2FftmJCGCu0oipXcfy5YU9i3y3MhZrHKdOFMSxJXPit6jLSL7BjZ3qP7fOVDi6dduM4YqEyA1sTFvJc/xMM+c7qaq1RmFwVOkJZREd4MI48NC8jV3wUcllf3R83acITbKEuc7WqJhZIqKd1xrFSjBPPGsrUVRF+ViZnhbIED8Mnl9uKahrRMcMN+2Ey4NAykm3wUSv+/hPpHM32n8YGI6e6QlCJTyC/oE9sG84EAH0HEb9PiPYICKJB/DLARr3jfBP6f3zhYscbx1nlBpD2sN1de0hMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Jp76uT9NmgBoalv8G6ZgSuYNOz3VoITCq6wn+aRcuKrMDNjPZ0cOQfmpA40rFwmKHRwoUiHHRLq7ZjH/ao148T3KlBrxDJ588wK8u2s8Xv3UBVBmzim6fzKaTyvzpEWxa0phGinnX9vx9XfhaIR8OHjnltqgZGjUamG6hCTQwvNFsoBIEHypchNuEecr6mT2aetzOWtNTJy3ipxnrSG0yTetjxHOsula1QuP6repJ6S2VO+FidOFUY2SPKfC8U7JjVr46mo9wOUC+oI3YGTThB+Zvn2e0UXhg6omGMdk6bUfZLy5tg2AUWKSeU9PPw8gzz4/p2SmTtBXRW0+aUEp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G1AwoixB9mGvd1yIGN/G7UCxlsyWrnnMzpF6f5LmClZ2ijHLPhRjPgeJHToC29X8a31Rz1S4p+IfJeI+JWMhiDtZEk8WSOxM/AhN4zZhd8oN7k0d+Z0LTAjVzjnT8iQMj/nacWziVYnlVKnIDfSGJEhlTX/ixMYLo5KoGlImyqA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4902.namprd04.prod.outlook.com (2603:10b6:a03:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Thu, 2 Mar
 2023 13:00:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 13:00:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/10] btrfs: pass a btrfs_bio to
 btrfs_submit_compressed_read
Thread-Topic: [PATCH 05/10] btrfs: pass a btrfs_bio to
 btrfs_submit_compressed_read
Thread-Index: AQHZTEO99KiGhqVOK0S2yu7SNn8oVq7ndVCA
Date:   Thu, 2 Mar 2023 13:00:12 +0000
Message-ID: <473be25e-dabe-34f2-302f-fa91c9304216@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-6-hch@lst.de>
In-Reply-To: <20230301134244.1378533-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4902:EE_
x-ms-office365-filtering-correlation-id: a3dd903b-a4ea-4619-b7a4-08db1b1e0f60
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bi0TKewt8JY+35loDZ/iSKoZlpFUCmCS0grLvnjWcvtGZi7HH1Gss2yYMJrUfW1OCbK1MqzDeVWZJSahb4iy82X/P0Hy5ex5DrnE+eCVLi3j/1kEAyYsr2Y5zD6NEUvIDIXxn4o+kgJe6tQS4vMNa5dN8amPaDiF+tfU4kEZRR2hvKMaoCy0jfKnV1bMhd6O0PvDf15P/xlo8F14q1kfRkmkPyIwudVw8g55iJxyylqOgoZsginxkk9nCsHRz3qsQycMFxDBXjcEVlrmJjR7DMqCb17oZxOFpSetLEZRAaNtETSoMGgg/HoCMD9slolQBBMl54Ql1guQXqCu8HMaicXJiTuPkonOFulZjdi9UdJOj89a7CfalfdMmPgFnNOTa5W2AeZXwsmLNAggzQztrxtL8z/h/VH348OY7IMjJ2+dOC02yAhbYOUdY6cSkieQ0UN4Btk29XIJ1n7OBjlBT/SI903161MQ47Nu9heTOk21vl3Zr0fNDwBYjNs746W2SUDJshGy0OphKH6oJlbRRPetEAL6slYu+bG4YervksZYTaELw4lP1hmfj3bJJfy3Ko56tT6VbrhgqsIkmCS8OEnVTotISjMv/amgiNRoEZDVA8EFlz0OZ/q0OYGS87HgxuBN/zGdBinHxqeTU9NHu6cH/Q94nS4f9hJdVAWWjLql8NP6HLCfXvzOb95U7qFdFCeN+G0q0AnbSvVsm3clxtjLgW5V6JlpugN9PU+2iW/wuOvxy98tL0NYcvxXXgzb8cwTA9lXIQyAQo4Ak/0pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199018)(31696002)(4270600006)(91956017)(2616005)(71200400001)(478600001)(6512007)(110136005)(5660300002)(86362001)(8936002)(6486002)(316002)(186003)(26005)(38100700002)(38070700005)(19618925003)(8676002)(558084003)(41300700001)(66946007)(36756003)(76116006)(66476007)(4326008)(64756008)(2906002)(66556008)(66446008)(122000001)(82960400001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXRpVjhyTzBtY3gwaTlZZHdJekZwRDlPUXRYTnl0N281dG5tUE5JYnFQWFFk?=
 =?utf-8?B?M00vUFowd2pXMzRzZmNEUncrOU84WkFraXI2V2FZWFJlcEVpcjJ2ZFJlbzlp?=
 =?utf-8?B?bysyQy9xS2lSRnF3Q2RzaFhKUzhRQWxGbnNzbUVuZnN6VnlYcDdIS2c5NVFK?=
 =?utf-8?B?cERGYm5WVEtnWGJuTHN1N2tTcmQ4OW9rUGV4RHVONUwyR0JEd3JzNWhoK2Jq?=
 =?utf-8?B?U2JGMWVyZmtqSTljNVdlSDFQR3pZaVlmVFc5dUdwVi8zckJLKzNzUmlkVlN0?=
 =?utf-8?B?SFpDc0lHTkFhZ3NHYzFmMnhGRExmMlU4em14cGtVQmt5YUc1WVpsNTl5Q2Zq?=
 =?utf-8?B?QnFaSG1FUWdya0t5czFGNHVZd3VNTUE4SVFBVlFTSUVaNUZwZ1BUWVNHdURr?=
 =?utf-8?B?VW42bnhWdHBVM2lEVTFuQThVMWxzL1RhZWc3SlRzL1FzRzBJdGdlUVFCZmlL?=
 =?utf-8?B?Mm13M1MveVRYQkI0ci9NTGQ5eTV3Zno2K0VRaUtpUzBtNFR6eSs2K0pIUjVL?=
 =?utf-8?B?ODZsdEpOVkxFV3R3a2VPWnRsMjl3cWgvdjV3Zi9ETVJaTWtUNVRrYmZhOTAz?=
 =?utf-8?B?K2I4bHhBNkNMWHdmMkFHeEtPWDB2bFJjRjhjUDNMRzlWZ3M3YmpJMFBPUDZp?=
 =?utf-8?B?QmhuQjVXeThYYkN4NEl3M0dTV3lmdm1NZmpaR2J6eUN6YkoxbjU1MXlGaU1z?=
 =?utf-8?B?M1pWd2NKLzAvRU9MdlRyL1ptQlFGZnQvbVdCRWgyVm5mdi9OUHBDZkxHWVd1?=
 =?utf-8?B?ekQyQXNocWhMMTkxL1JYem81cm94QlBId0RnSDdsWEcrMFUvRzBKZDBaR0I2?=
 =?utf-8?B?SGRiRkl0L0VIUTQ1akdEeG95K0NTL1psUzFlUWcybUd4MjNTcDE5cDlaSWUr?=
 =?utf-8?B?Q01BNGsvK1J3UW9qWXU5b2dkRmJSeTJnNE1yNjBhTmpmSUhDYUVxOFdVaW9I?=
 =?utf-8?B?eitxbmVuVEEvQTErbzZwU1l2V2tnNDBta1N2VkFoWEhzSnZaYUQzZjZCRitk?=
 =?utf-8?B?R2lNVjhndXViWG9xR3JkYm91d3diZXBTb1VDdFpJN01NK21DaTVtOSt0U01G?=
 =?utf-8?B?WEphZGxYWDE1TkNqaVBmWHA5MG5jaHBOVDNYbkZCVlIzNzFZc3VmS2RMZWdI?=
 =?utf-8?B?N3JEL1FxTmgzdnhtZ3FTSmhEN2ZublZkeENpVmRlbXh5azhIM2lwMzlCNThM?=
 =?utf-8?B?Y0FaeDRSTnJDek1odnNGT0kxQTc0SDVseFZiQzJrOFJNZkpMWVNwTVNkUkhE?=
 =?utf-8?B?N3NKalZ2cmIvTW8yMFA4Y0taeFRramtpT2FpWEVyWS9tVXlUdWJTQXJpeGF2?=
 =?utf-8?B?S0U4Ti9jTkxlbWhLWlU1ZkZjeEhIMi9mVENhN2tNNVYvUTRLTTV3Q1hzcGRN?=
 =?utf-8?B?ZVZpbkdJMTZKQ1dnQkp2bENGK1ZGaG9Ydjd5MzJaUmN4YTNYMnNrd0lnY25I?=
 =?utf-8?B?S2ZzR2FROUlhUmM4ZVZXSmorU1FvNWZiWmhoTTV1dnhOcC83K3ZOTWlnS2FG?=
 =?utf-8?B?RWMwQ0FUbktBSDBPU0xSMXNxMWxLQnIwaXR2UWNLcGkyVS9aU0FLYTloaFpx?=
 =?utf-8?B?VVZYUDFWaWtOMlFVdVplZzNOeUxpUjhMejlEODZ6MmZPWTkzVXpnTkgwSjB2?=
 =?utf-8?B?eWZPMTVvWGI2MFNLR01KVEw2ZzFUSTNkZHpGN3lqaWxMN2VGOFVHQUNqZnlU?=
 =?utf-8?B?Z0FVYUF5N3ZRMjJ4N2FMa0xjZ0cyOHpJeEIxZjJKdlI3NWtSRUNwdUhVWnRL?=
 =?utf-8?B?ZlFucmVSVllBc1NNdFVoRW5IL2hoZ3llOEIrREhLRnA2WERMeHNlSjJQUHl5?=
 =?utf-8?B?Uy9LSHVXbzNyTG9xa2pGcW4vOElldDV4cG84WElKeWFTUWR6Ryt2L1JOZjl1?=
 =?utf-8?B?N0FaRmdYSE9xN2o0aWJvYUFrRG9aQkh5NFBEZEMzZWpRVUJIZzVhWE4xZStJ?=
 =?utf-8?B?bjRXYlF4Qkh3d2I1YzR5Y2g2MW1sSDNtNXJxL2tEZFJsMy82WDAyayt1ek1s?=
 =?utf-8?B?QTdKci91TUNJcittcFZ2ODVjRDBrcW9CSEZBVTdhRTNwQWVCbWZNcVdKdUVF?=
 =?utf-8?B?WHhLdmYvODNlQjRFM3JHQ0hncjBwREdMMmlYR3Jvend4VUtjVi9yRWRwL2Fl?=
 =?utf-8?B?azkxb2tUMkhYa2ZWV0JydG5aL01JUzZsRDN0aHlWdElseTVwUUgrQ0o4eWhn?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A486B37A9661544E8BBAC5D7A1313E23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c7Fu0a5YiJb3k6VL/+zTxXlQlhFoRqlQE+lyljONYvPAKOPYYh8QSipIKNKIo4pvRWy3gPZ8ZXOkVaG4QnpgzP+zmoVtxCWe1GeagJ2YjsqXymaAaJ7/ZVdMzuX+Hamcx3ve76+or5yREwKLJ6igOE6VoN+6POr4yT5FH7ohi2TyHoxJPHE6LuM6+R0BHSRLloqFUzzK2xYCXHYWfR+6ANc6h8DR3ts9++EtL5z6e3+rgtiHvwdm2nR8+GBpfTvjLyMc30/g/5uymC01VimVs1/JiLEwDjK86UhOJ4LI8fLPYt10A7IoqsIagCh7AlIaZqoGxr2y3cqdAdFgebEL0ixnJJTV/VkU52ENsF645WrkYFnCaPU2gDDCJfrYoBINGgHG+Kx14pctY7p3ikNYmJWpkPv3RPXY13HBMoEH/h3NTxuJXnIoA7AN8hzIkcu+6V/iS/q5AHePERJ3QdTJFe/FQ8YwDVyKIQ5PWyEjDbVelaBnmrL26ZceNih3vFDHjvjEEgiW4Wyc4Wfg5yPSCLe3UCitsK3e79O6Gn8M/RfSuf257NPfal4EKelBZM9T/ONhWkYzV0US3GnpJ+OOqUnOWhQrwNZ0M9YVYBt3OSvA01KiTIxKXx0BZszF+qEOHmuc6BRfCoweFgwBXDwAN0+7njQtYrHxeaCsT89xBfyKroUp7BRS3r5lRlMzP/lrewlqpyungvkTbmBcJHBJQdo5vzQWVv9MAA/MIYar0/Vnp6itbfYtl537/Sg7UMPj47LyczxVjVLbfq4DpsNVwWfI71t70xtTfoDxAoDqcDQBsbYU+zI4V3JpboBn2PTqpBs6ZhjSRdKLdXn2k7trrV0DDlN7QcjboprLBy5JKYo3p8Hs2wqWGuHigvbNvqVt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd903b-a4ea-4619-b7a4-08db1b1e0f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:00:12.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvuTxGNB/H8+W2GI0aFm3aw2+U9VjECNV60d2MLn8oBglxlmtgU0sS38uL9OSGgdP9eXoG5P3U3Op+O72reVWXk8jVY5dE+xeFQaQVHzEP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4902
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
