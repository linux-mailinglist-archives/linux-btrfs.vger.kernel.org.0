Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB16A81FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCBMTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 07:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBMTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 07:19:11 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B51360B3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 04:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677759550; x=1709295550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CnNmXJMOShia3NSLa9w3KBDQLa9xr1kjxMotx+F3DIqIgZNoENsYR4o5
   yjEh9VISPunTcFhm9l4CrjLbaHqivTk/jhpEJ6TCqYi27uGGU5AID7u4N
   PajDR4MJudVXSG60y9Gp4olQOBkla8Rl8yXGdXSP9tMF104D8c0M5AZN5
   Y6uN9YTklhBUzqiFDb/J07fCezilf5vAmz9zKH4wZooKDX9pfinTDLLtH
   ilHl6EYpC291YiEE3GefGLAwr9Wi7n3VDLMguY1XUMOfLAdAcyB1yi1+l
   tW0YN2K09WKO77JrW1Ge8qfy5x/+tIauDF5KJYom2Ffv/0GOFE8nvrO7g
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328951843"
Received: from mail-dm6nam04lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 20:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ksg/5cQE/gjTKw3PM2EGDVLhbh5dk7vkvymZt8f1Bselpn7cAUOCXh10ap7l8Jjuf0dHN5dNgcX9ZSsGRbO+BzlnEr/LTlHCTkVFXi7+wWKtujLo+ELyYAdaBeMYIJSiR/m3ri8zkB+HZdqa1OOFcsVf/6PA1ayGiNJyNxNhkddzVAF5QAdlAQ1/umtSbtZVQ30bowGiejlEDa0pZLXgItCCDTFJvUOgO5cPgrlUG2fg5NtnJrdd9jN/BIa0UbV2pc0e9cMuC7eJzg93aK1zRulvQojb0uUyUY1PIEWfYaK1nvYLEyLnXL/r9wNARqUAoVtyuqs1jnr3t21CRfp0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VTTXfnEqYJUZspSoijby1fRJraag6toCEgoztDWroR+DC94ZBZD2JZ2qjyPobuP8IlWNK8ehjApblnrG4vTqp11ISQHYT212NaokRZwvLMFGlILp12Ryb9vwgIsYzhzKWiSVrYQZK484AqoVq5Ayu5HFEwn85Rs21BVImJoVMo6TB5qTDn1uqBOJCPFmfvp2oz7vSWFcaWDFcAWTqMpnxWDkPPQ3O0zFd8tgEkKJuGOCHNIEKvfF2kns+ljO1/vMJOPMnB0ZMNHqjWrECaU5uOTdMrX+cvD8I+cBQ2natTLkbFm1yJR3UhWeedzi/bMMJ81q40Izp6Dc4vKa7UksCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ad3/z8EJuOp7pPjg3SBgkcayCX7c1kooQ2xPYWul1MqUfv72+ZLZ6Tw3JGhk0L+UATrpeEZkq193mq85ipcLjbMFSZtHDqIy5n++/CL9IGpuvhfCsJ2SkQRp16M4bervy5SmYsUk2oK6KIOVz5vpwwzSzVLeHRi9C8jTkcJrZfg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0662.namprd04.prod.outlook.com (2603:10b6:903:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 12:19:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 12:19:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/10] btrfs: pass a btrfs_bio to btrfs_submit_bio
Thread-Topic: [PATCH 04/10] btrfs: pass a btrfs_bio to btrfs_submit_bio
Thread-Index: AQHZTEO+6cxtRMLZLUSLBsJCV3XgwK7nadSA
Date:   Thu, 2 Mar 2023 12:19:05 +0000
Message-ID: <9cb468a1-3355-c2b1-b71f-5fb843b529ca@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-5-hch@lst.de>
In-Reply-To: <20230301134244.1378533-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0662:EE_
x-ms-office365-filtering-correlation-id: ca04acdc-f1e4-47d9-2461-08db1b18513d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXCV2QvNxOZPeSRfspFE6a7D+rbSYssVvjJmF2A++AjYNip73/69mhUdxMV9OHaCY1gWpJrxnTWT4MoenTn4qNr+8Al3mN74kpjRGbT7z1askYr88YhhfmMJkJyF7j2/aZrKTl9MDq5AkxBg/mqFUMDimUydDC/qzehgmpaOO03XXLjoJRJLOLLC8BMd24CUUTkgYDaPw183ILV6orfh+BmnBe+YWQ7nGrSuaUjydQcd5VfYcoRZMgvK3oZ7s5p1SgjvCgp57m0Xu1KEu0UbFIhiFlaidcR/+hGZ9owgQb+qe330GDAu34AEKUts96ghxJ4pfoQLPeMMwh8SVZQAFZxSXFEFVUEBtJCS4Ys0yJ0BltL+V+ju5sPLwI7i//iArSE4DPhoJbs37QVvrYFAuksX2FQT804ZFJuxMA9JyVE7D+4E2FfbQQJnwr7X1b1ohv9C2T07cXJnPr0Uc9uYZscSkTC105e5FoyxPbwG4GL2OS5M9lC3N3BQXOJYSdG8VmKcAAUMAfAZhgja1BndbhP7W1Wt1HyijNW3lqe/ZuY5oM3qQ7c6ymcM9IZJnXhjZCZtD+uTVS2XRaWeJpcIe5P44MYkmNnBqEtDMrU7xwlLYXPbKOBvHkFCLKM9XaXNsG5cHYVY9DSXh5VD4TAZyLJsUfPJsUryzYn2uuBH31TOhMlD1djXb5CJJi6+NvYLmswlikJx064QPAorEDcvuXE3cj8IYgLh0sTNs48LqlxIUx7/mQhOnQW1kB6mjoOH39OH0INeKraqRv+6LCcvYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(19618925003)(122000001)(82960400001)(316002)(2906002)(31686004)(91956017)(558084003)(5660300002)(86362001)(36756003)(8936002)(31696002)(6506007)(6512007)(66446008)(8676002)(4326008)(66946007)(76116006)(66556008)(66476007)(4270600006)(71200400001)(110136005)(41300700001)(38100700002)(186003)(38070700005)(64756008)(478600001)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzU3MllOSERGZndwSDNSN3VtSVVXVHpzUUZkeVhxZzdQYyt6akF3TDU0YWNC?=
 =?utf-8?B?THhpSFRkZHk0bVVDQTlld3ZyRGJRMUhsWWdtczFETVo5UXphTk50bVA3TEJX?=
 =?utf-8?B?cTJtTnljMEM3VE1EcVgrODgyNHAyVTg5VTU5WlBhbzRzbmlwNWZrRWhPa2k0?=
 =?utf-8?B?aUlySWpsdXljTmprdjdDWW5YL3VTbVZzZ3RvdzZabUZUMmVZMENjV0RLNWpQ?=
 =?utf-8?B?cnQ5L1lWQ3VhZ0RpcEVrdDVSd1NKZ0FhVUFVU0tsSE9tZ0dkZFNZd1hLYWp2?=
 =?utf-8?B?U1ZBbFhKTUlGWG83OG9Ob3ExWmxGVk1tcy9lcCtlUUxybVd1MDRpaXdYR3RQ?=
 =?utf-8?B?VktsTHlHYUFNMTBTTFJaSTJHMXJQV2xZUHF3N2tRWFJZV0xOWURVeXdsZlA3?=
 =?utf-8?B?WDVIMlhaOWE3Ylo4WFJXRUNrbkNtMkxFOVFibTNIeHRYWklqaDBhdjRqVS9n?=
 =?utf-8?B?MWtWL2J1MitCMDNhSE9kc25PV05PRFkxdVFHTDRvaEFtRGk5NkR6TS93OWRr?=
 =?utf-8?B?MnM1VTE2Y2dqc1hpYWViQyt5WU9XVGptWmUzcnFiNk54LzRWUHRCQUZzdm9I?=
 =?utf-8?B?OTJyY09pS1kzY1dUbDhXbC9KNUpLc2ZPVGVlcHI5SVhld2ZIUlJham9Kbk5u?=
 =?utf-8?B?SWZXdmFQeHZUUEJQZXpXZU5VclZxQjJONUE3L1dVclpIVlcrUmJwMm5zVlk0?=
 =?utf-8?B?aFpRUTBWUFJRVHJNeHZEZDhVMmh6NDJQRWZGalFrM0VMbUI4WVptb3R0VE9Y?=
 =?utf-8?B?TmI3dE00UzkrVmFBd3FYclkyVEtYbFA4a3NFZ3VLVUhmbU94RXJWK3R5eHFS?=
 =?utf-8?B?S2xWL0oxd0hDNmZuaFR2ejJpUGFwZUFmTWtnN1o2TFBubHU1ZzRtdGNCd0U1?=
 =?utf-8?B?TWRjVVgxbk91cmhZRllyNzBuUHc4RHNWeTE2RHRwNnI4dVBDVDhGVXVIUFFw?=
 =?utf-8?B?dXp3MmViK3dQZXhkamNqcEd0L0xVWkhjQmptMEd0SVpwNTNKYUgvR3lLN08x?=
 =?utf-8?B?YnRiYjVGeEZPOWxMRFFEK3BqTkl1aVB1NjZIVFF5dTJldnFjNTJlTzRVMXdS?=
 =?utf-8?B?VGptbzBqWEpPQ3Zwc1pvektYMHVxOEZwaVc2d2hkVUt6ZWhOc3J4U1IxRzNX?=
 =?utf-8?B?U1NEa0tWQ29VcldDdktyVlJjT090UGE2Q0l3QU9VbUdLK2JHeHJvVzNQMmhi?=
 =?utf-8?B?VStFUHEzMDJvOW8vNjBrWmd6MFAxYUFONFFwaTMyL2JTaU9hUXFUVEZTWTdx?=
 =?utf-8?B?YStUczQxb0w2UE90OWZoWEZXVHJkVHRaUlBDSXk5ajJldDRvWS8rOFBvY1JQ?=
 =?utf-8?B?TytWNmlMWXJQSGhRRXNDcUtGV1FFU0N5azlIMUprcWZVWkc2bXpoUTREQzVt?=
 =?utf-8?B?azhMVnhpVFRRdmFSTTdqM1dhOTVrcUczZHZRQXh5bnR1OTk1MVZiYXdETkha?=
 =?utf-8?B?QTBrbTdqYTgybWdqNXNyQU9ETzFkcGE1cDRLQ2VHcE5HRXVUd3BnSnlFaFRP?=
 =?utf-8?B?OCtORDBIZm1UeW53b2tBSEppdkJCNDBaVGtMZkk5Q2plRU1oRWVyWDhnaDhS?=
 =?utf-8?B?NjJtWVQ5a1A3L1RDeDEwTDc1OG9CTFc1dUFKMXVDcWo1OVJUaFZUUklWZDZo?=
 =?utf-8?B?bzBiZVJYOG15Y1hzMkxZV0graEJxMVpmQzU1MDhkV09ZSGkrK2xTeld0VXZZ?=
 =?utf-8?B?MXhGRGQ2dzVOWWZFc3MrWGk2cnJ5ai9LWUs3V2pMQUt0YVpUUCs3d0ZodWhn?=
 =?utf-8?B?U1R0OHlTL0h2WUYxOUpNMHZDUE1ldlAyMVkxMjh5KzV4QVZxT2E0NC81Y01S?=
 =?utf-8?B?MnRMWVo1UWdoWEZWZTdKUVl2QlUzRUxHR2ZXTnNyS1J6cnR5M2lKY2Zsd2d0?=
 =?utf-8?B?d2ZJTlVWaFllR09kVldkVmk1dkZSTWNlMFZCOE92K2NMbWlwdHNxa0hPdUNQ?=
 =?utf-8?B?dWpzeGlueHFuRHRNa2ZPWkVYTTRZZ2tWQ2Z2Y3U2N2RzZWdJSWNUSEZ0WXN5?=
 =?utf-8?B?SmRVdjgyekR0clhzK3kwRCtlRGsvM3YrajZPRHBLeHFqWGRCMEltS3NoY1lR?=
 =?utf-8?B?STczVHhqanRpR1BQN0t5SmhrWmh6OXdhQnM5TE9mRTBkaXM4S3B1RXhHVmw0?=
 =?utf-8?B?R3hkamhOSllsWDBlV0toUWlZdlhjYzZadWkzWmQwbjRRM21zR2gxT05zM3FX?=
 =?utf-8?B?TjNGSkxia09DNFBCaUhPUVRkQnJjUGRnODFVc3lMWXYva2d0YUh2dlNNNHIy?=
 =?utf-8?B?T0lQWlM2T2tYRWFJUmhoejdYbVZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AC9EF1FB04374BBDC4C7FAC9C863CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gQr2+q0af70VY7ytrq2mPxFy0+cTVqqt8fWQFIs3qzKus8wm80RK8J6K92Mj0Vi6a9s18i6EmPFSpmauibj9U7+l+BZa24rarU5swHeCL1jtj6wtjPPhSdpnMAL230drYiKEaqUDG1XV8iEvFHoOlFs9AyXq7H0Nr6f78w9co1fjtkVbWJDRklXoBCg8TgNF4FmYN/ctawHuPJu4K2GLpOPldmS+2DGFKrbP6Qg1oxnWSOQSfKbwPrpDKPHSjjrI+mftLZxQfvN0cynmYJrBqMqjsJ3s9FtuXOvW+4RdCsQFmcl/Byn9IHj+8HkIxAzXXhtF35E/v+Bwamp2iS14THnfLA8HR9bvI7d0weeOYocLjMCFYcwP0KuNphYLubgfwBTyB8FnH2vTK83LaMQCpTNfxtdvJP6tmVyNosiX+qg58m65URM5kRZ02B+kUZ/CbTxFUGMljekBMKpjQGwO29FdNRMVzU1wvBoA7u6Lvb5uUqmOxHrWjg8xnhJ9Ul4P54BNvNPEondUK3U89H5XPWYJA9lx7n7CTY9PVZn1b5d0z0Q3xAeeIdkfQzLzEaAx38KQX//rVucVHvzolllcSZWv6c8SUm4DrYFjOgD72KDUCkhUYgAQ2y+kxnyqB2bSOqiwaiHd/nleKWA9XMlwyOJ32bjV4NH1S9jUoRLUzBDwMtvsw/qe5HuE691vdRPC/K0mDHoWsjqj5axLeens7rwbROEKpnsOgUhJdGIUdQfZNz5W+AlR8XQdoYsxaXfI2PtpCktEHSSf0PEwln0b4P1ptbciKl6IBgqV4LRAtvBZNRXGFnKXd+/MChP22mo1Uq/UAaDU2i7y1TOWvA4bZK9ZXCEG866Cc4swuaEI5UbyXbNc/eCbuudf0otdRTNx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca04acdc-f1e4-47d9-2461-08db1b18513d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 12:19:05.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsroDWQZ1pR6BaGntyU1FNZ093MI2Tn9ZwYLYdSd66k9A4z9R46qyvubmO/oHHFuGjIUoP/hT4BqfeyidvtVtZCy25rCSN6ewFsir08o38s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0662
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
