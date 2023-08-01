Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3876B5C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjHAN0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjHANZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:25:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774C198C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690896325; x=1722432325;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cPhr+qXD6kPLpISMHh0jluaoq4/N7O/GYrA8iU00bTWSJLycfQgzf5fO
   uVkKgxOcJCbpSGrRQvstcTEyvcylt3bQgep7aNQA+zxTGvT8bJPGFm26A
   tDanTx2FgTM5TqYl4sq42a3u90iMRWk36QXyBIQbFwN/k7wzuXSM0riq5
   l3C/I6JVppgKrkUQMsLcNbtgWfKgF4vSrIy3x9HV5R6Yne0rgpAW4Qauq
   opRP3sw6Tnecnje2L1PaAFwQpjuTiYIB4NXdU2u3jzwbFO2sLhFCuri3B
   Lkn4lmofEvwC0YB1h0g4bxBlkQnM9PjpmNPbSVBfXJZxB8whiaSYZ8/ce
   A==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="239627149"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 21:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6sm84HFUbPv4vhwcFssnH+r+VGudkyilvmZkduyFuiXtJy4hNU539NqfKlFZJpt16YSUkOSvYuMeauAKcnBV6svFn+X6YaAcqbOUIGfifS6FQFhaUwnV/vrqwFQgW1+rRzHqWo8Lq2U7feNPeZ5j1BuFQRUhJ6IQ91/WaTa8MHh1rdi5ZVhO03BgOQMNYguPhG73S8bZrHmmXM2IlB0ab0Wm481JmrjY2HRJU0rIAP8X9rgFfgpC/YBEuRLVgXSIiB2QsRGcGmZq1ZfWSmp12DhTyLFtftcidyT6BQyr8sBnoQjh9+JB1J8i2lSNwwpRbRGZRbOqlKLAYVwgN3mYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CPXxJLOpBPsntLRYZsvVeLf3CQ4M7BWYK/h081RABI8SfO9qkxdJ7hbdazsUYDs/y2KXyLQIFpAeW7Zw3UZgo1B0ysE0PdMr+nIlIt/J8JRT8s1jNwCQ2AdDB/1QWVcY7m9xBRePwrYeg2zl+7m/5pG54ConiHe21bO0M0G5Om1BpPy8djF7fQfVFmHRFY2mP5gDtasdpVF7gmpx+iwdpm1j3IOWBMelOnJ/nvkcI72tyVJoWG4WohWVC6sOfJUN5f96k/Lr0slXmyHTYP0FRjqTzNGc7aZrs3bVwwCnR4QMPwww/gMrdPQ6XlwcJjKs8b6FokbWLjQ7X6FRQbERFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=vmr5de/yRjIoJpigTaN0WJvQ21c4hZEyP8pJghH5+PBqV0bNSg+UcrdiASNHieQP7R2SK+yTi6TeU3le+cQZ7NKl8PhBzV+rFjWxwJXNJaCVbdFPSNi2XhwlJ3O9qNezr64bmshk1v3TDVVYtDKs+K/rKJA9bI+5EZAGIRMW3Iw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6821.namprd04.prod.outlook.com (2603:10b6:610:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:25:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:25:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] btrfs: drop redundant check to use
 fs_devices::metadata_uuid
Thread-Topic: [PATCH 5/7] btrfs: drop redundant check to use
 fs_devices::metadata_uuid
Thread-Index: AQHZw6C0Gm17zRVGvkOe0nENwNDp2a/Vb/eA
Date:   Tue, 1 Aug 2023 13:25:18 +0000
Message-ID: <0d4d6419-f9d6-7aae-454e-e7d881766574@wdc.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
 <92f71226c8eb0797931eda2c92ba243113104a69.1690792823.git.anand.jain@oracle.com>
In-Reply-To: <92f71226c8eb0797931eda2c92ba243113104a69.1690792823.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6821:EE_
x-ms-office365-filtering-correlation-id: 837cc4b8-62a7-4d35-250e-08db9292bfb3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFGkxAT8ruwB3KtHHcPnYQiswRcGNzfM1UYvPbcRvMRAahro6bu0jtLrjfuOlNKwdTZLL9nBLokt7CKvxQmBkkwL3JXKCkpkQG0hqmGIwVLcrCkRDvN1JmfUDFYBJq967j7mr+9of9BWFmcLGtjSo3L+PwDzbeJddjwD5MqByJ4aYLSOhMcEBq3ARx6rOy9SLeP3UV81YXsasGUR3FE3ZThF4RaQPzlPIHnVUcy/A1hRtQilfdYzW50wXMqTx0tdgitQl5V21zObV8Ic69jktsi7m3YAdiSJqvTYoMpAAEYk8TETeD3ckaw9hJhMAvyAcoA7AwV6l4OLWx3HrK1IhaAxgfxW1IfrWjM3Kg1W334FVLflrFgOzdxMpj+zAH2Ic8+PGZiAIgPBvPX4QoAmAvL76Sv8lqqt3CTEgiHMmEDIzZgNKtgFhMn0qM84/OhjJGRCTh5XeWxnP7kpA2+ez9/dUMcg5Om3P5RZma6WrSWjrgmd+I1wyjx+IhcXWIlTeA0kwz52iX1EHmz4g5GNQ3hEHHEQw+dIDJ+YRBNN8591hGbSPT3pyticafDH5WbCYtpWm9KvtwMIZNwPb0s5rvXqVDIiLyz+XpMnTlcIzAE+FnwH9dTzDlTeZT1IEzrakcGSEbvJWznP7X38z9KF/nA7F/D7hKjv1dTknt/j+gHpXhn9DAOYIrRksbAoSE5v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(31686004)(6486002)(71200400001)(8936002)(6512007)(19618925003)(478600001)(36756003)(6506007)(2616005)(110136005)(26005)(4270600006)(186003)(2906002)(558084003)(38070700005)(5660300002)(31696002)(8676002)(38100700002)(86362001)(82960400001)(122000001)(66946007)(91956017)(66446008)(66556008)(76116006)(41300700001)(66476007)(316002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9pU2NkNjhqSVc4NXZ0MDhHOCt0NVZPVlZMMWoxU0dJYThhOVpweVhTOVFB?=
 =?utf-8?B?Mmh2TDVRTkdwdzNYYUwzNWl3cWkrME5wMEp2WCt1NGJaek9wUkdXYy9NUWlu?=
 =?utf-8?B?VHNlNHVnWk5ETW9xRzBLbC9rcEs5K2Z6WUZrQmpVR2NKMmJxcjdYN08rWnhr?=
 =?utf-8?B?cVBYTE9EcU9tWjZYMUxCY0pyeXFEa0F2eDY4ME5EQ1E3VGJUUHE2L08zRkRn?=
 =?utf-8?B?UUEvZ3FHRjRtVmR3VzV0bHRobUdRTCtRbUhIbm5ZTjlJRXBVVUlSd3d0dU1v?=
 =?utf-8?B?K2NVblNpdldNQXh6RTRQVFdKVDlkV0xlZ1MydkU1dEFJZUF6ekh0M2xTR2Q4?=
 =?utf-8?B?Q0M1cHlHU2YzV1RuTTBkZlVNY29SSjlEcGpjcU9yb3ErY3RxdnF4dFduZnVH?=
 =?utf-8?B?aHZDR3VUWW5QdFE3THcwSVBEZi8wQldsZWcxUWx3eSs0MS8zTHlTbkIvTENY?=
 =?utf-8?B?SElVSDBXNi9VM24vZFVFWVQyTFpsZm82dVY0RkFKQkxmVUozRFk5Y0lrcHdI?=
 =?utf-8?B?NDkvY05kdk1yNDNjUjlKemk4RTAvdmtSek9KY0RIQWswVENZYjVwUUN6ZzEy?=
 =?utf-8?B?VXZoUXZIRVlxWVpwMDdBQjRRYnpsekVXKzR3YUFSdXZHNEZ4d0pLV3BicFQ3?=
 =?utf-8?B?WkdXZHZhVTZNOEluUFN1NEhJQ0lBRHNyekZXZXQ1S2lhaFlzdVVKMlQ2MS8w?=
 =?utf-8?B?WHM5QlZTRCtqZnRJNzczMmZhcURRWUdQSzEvNjVYbVRkZTZxbks2YzFvTW05?=
 =?utf-8?B?b3hoREVnMjBnNktqdFhTRUpJK0ZIYUxYUVFtUEhPTFZ0VHpMbHgySFdpczNK?=
 =?utf-8?B?T2tSMHVBVkxwd0NOak1rWi92UmZJRjVrY21LR250RFhnTk4vWnJKMlR6blh1?=
 =?utf-8?B?aGxqMzJSTU1NZEtRYnFpK0F2ckwwZlVIZ2FFTzNZV1BtOWxFVmJvRjc3eFBB?=
 =?utf-8?B?NzM4VHRGa0VKUkhUN2Y5bGZCRkU0TndZV2NOZWdJL25BWWxZck4yTzRGQ1lh?=
 =?utf-8?B?QTNTSVJiRzg0bHR6VThmODNoZUdHdGJJd2k1TTVnOHhTajlORDNSU1ErS29U?=
 =?utf-8?B?ZmprZWpkaGFVcmZKemJwN09KZngra2cwazlKMUFpUzM3bjRERE96bXJRV01z?=
 =?utf-8?B?enRFOUQzWng2WE1EOWRxQzdOSVRhcmFaNzIzSFlSVmpGQ0lYOFZqV3IvQll3?=
 =?utf-8?B?ZEYzRmF0VExSZXA2ZWR2LzczTHBJMGpqb1o5NHI0VnlyUUcwZDEvQksxcjlJ?=
 =?utf-8?B?dzI3SDhvOUNpbEFvODlxa1ZqTDZCVDhMZTZzMksrMDJGcEdMdFIzVzIwR1h0?=
 =?utf-8?B?V3NLM1pQRUtYOVV0QlNNZEk2eVZnV1lIN0JBTUd4N3VxaHphdVBnUHhXRjdX?=
 =?utf-8?B?QW8rZ2ZlWkQ4dW13L0JEZE5jUGhxRVE4R003OTZMQ3VkN1pXOWZtS2NFRG5Q?=
 =?utf-8?B?N0dNclR1dHVxQWpLV1N4WTdTQS9IcTVUbmZqd1BUVVdjUlNYQ3FjOUp0bFdt?=
 =?utf-8?B?SFlaQWVuWUp1bk1jd1ZWNi81RWpUVkk0NGEzeFBIVFlqMU8vZVVWVy81d2s5?=
 =?utf-8?B?SUJCNjd4dFU5UEs5UzJMVjQ4M0VXdU9la2hpc0s3RzU2TURINFBkQ3RDWWhk?=
 =?utf-8?B?ckd5OTJ4dTFvbXA1T0xxRnA1MndHdURwUE1aNHkxU0NYOVZuWG1jbHoyMUFF?=
 =?utf-8?B?bjJHcTZya3BaOHVoTFJkMmlrT0g3blM4YXVmMG92a1dEWC9HUm1YaWtTeDRB?=
 =?utf-8?B?dXRQRkpOZGlVRVNncGhYSHdsYVRVU0xJdzRTYmxucE1iNG1kTi94K0s5YzJn?=
 =?utf-8?B?NWhXTzViY3NrVXAzaHZmQlZBQVVpLzlwT09WaEhjRUtYTCtqbVdWVWl5V3VH?=
 =?utf-8?B?QzRTOHpXNHJ0K0o4L1R5aE1IeHJYMHlWQTFHa3kzQVNUZEhsWE95SzdDamU5?=
 =?utf-8?B?WDRyUm9pWk5yTEN4UEsxNEVLWlB1VEhKODczbTMyTUtiMHRWQVBEdTNOZmNJ?=
 =?utf-8?B?RE1XL05qRVhVQ3NkY0VsM2g2c0ZHUmlGYVh3ZXAyeFV2dVNZQWZnRkJuc1pW?=
 =?utf-8?B?R1ZqbGtYVWd3VGhhUmxoTnhMUEhzZ2dXYlgrQVFDb1FsWUlsU0p2d3N1cjk3?=
 =?utf-8?B?cEF2L2RucFVndkRlWStTY3lDK25kTjVhckxSRlcxOUlDK292cm9JSFd6WlVw?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27718A20AD59484295E811CB5B4D4469@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7fzAs+cDkEHyOHb8E302qdjXuI+cmhs1C/W7EYYr3CgvkLh4oEtugorfoJ0knojp2sguYTGafpSmH2DS35/7XSLf/nXhFpc/vNWlE7ZCE63Fn2i8dHDmhXcE1Hec9YV52rJoopBEEywcxKnoiy6dzBLr4sAB5cWWzRVn8pJ647QunwfcXDY2i+PrUeLdhGuLx+o2wRtnidcCPIQ1s4aien98cBcRkY2Xa7+uCBAyo0htFyXMPA6bf5rSfwMYed53J6QQW1cfzBZ0562L9JgQtnyhUvhUXFWa6Z3agB3M5YLYbNI1jxmc4YlrPYy8JLbs+WDbYDeQzPMwAykJ27YumDhCeCIUli21OX/gq7DUlcUcMwzqb/XzYKU2jtnMZ4mk/qaPqdM/gS+KY0gybQtS+DcUyHtBrvGnC72iI6ED3tQTiiGla89sznQ4za8y67Na5SyAdkoSDX6/HU2e/UVxoKzCz25FGgFvZzYRsQQxdS0BghMZ+THKmbYgwaA/Ro6IAzDvXLNP+FjvOkcVAhLGsXNdKmlYw9psQDluZ0r3swPIZyZmflqj7j5DEGv8LnYJ8K5fe2A7eSzhsJkeGnrvi5g7z0de//TXsQPTCJ5GZYHQbYIqf1oRlbhqG5fH7YvWAyki+AApnWbno95FJkKX3Ho98Kwb3c2uzthX5yQsWjyqVMTcVClO8/VahXGKNzkxxWYZhAqghh1l4kWqq5BTfqLQqzXpTvQCQzPOR6BFozOtdG727LeJ+EOzba/ziOGHEogA2jLMq5W2GYsqRX7oOwlIKwHVpqm7kHr0qdYzS1t5z7PdS9yJJjkQtlIbjCzY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837cc4b8-62a7-4d35-250e-08db9292bfb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 13:25:18.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XdSOZQ2fTc9q0MWVC6P4Xv2qwJBkIpwIITVbmejwt6I8nNc6wJqfQHeddgYvftu+IqwIyXc4BWw2kz/qGC3F/Sb+OLTkZATsI2B/L8//ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6821
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
