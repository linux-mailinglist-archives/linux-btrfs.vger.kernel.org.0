Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13C768EBCA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 10:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBHJjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 04:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHJji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 04:39:38 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86160131
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675849170; x=1707385170;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZM+PNkqCQwwR2rDXLrCBFSPvMdq+2eJ1/1dt2+rAb6IAaG+Tv0x8uAEG
   MEYOCiXYqRdCSOmVRVqAyfEw93qOeC7dGmKNxWe2v719sYbcCKGlJEqeR
   iJJJLJ8VCISFNnKxTiuwyeWT4CyB7h3d0eFlqdaYsvTSguN4q6Yp4twMu
   k+PVLGxVWz3mv+kv9CVo+WwdJmyaWeJxOXsXXl4/cEeCZeth8Qs1np7gz
   11yBLzn0V31+WWKmuj7qtUyZ2DLdlibnifBXr5yD4NX6ZIO1zmFoSUpEG
   RlMcJihrZQaolc/hMFtslQ6Vv4qb1hknp3hAyQNPuc35a5wsYkui9vRLD
   A==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="227767519"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 17:39:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/iBmrirY8G84XCPILDA5YXQ+jAkrPuBZHcbRrG2sCSTjr1xBownYPdrAg8r9X+kUI/qetk0REcRllBDPYG37u/e1WwWFNzRMaqDP/wRbW2lfGPRMfbTHSMe4l4CF3qhGKCZS9AEJr85dZpDWVahL9GLR9A7qM5bkJnKdInPAg7g+LdRNQJbqyWHbG6iTimpLzra5EAwRhCTOh5HsyGVlOsdUMX6uZq/dyVqi0EZJpU14L1ieioTIiyWJI6nbQgXJVTeugPKOsz6GRAM1HRKVmRZHWwr7ghv5bA+ame9KuYbUJh8CCMTssm/gHE4MslB2JIapb8oZ5Nuq8lflu+rHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ABi8npN1I3+ZcU7WOdE/C2V26kyo7gZOA0SlhTsEjQ9GPDSovYA/F6oYCNrwz2IhBQU3quT6gGY59AkZZrnN2rYTc3Nx8e99wxQeEU5PXMOKDkmtNLX+y0nN1PindZcGF4S6L5NBH30wPfLIzXebxZhiM0ld4EQo4hcNlxMUZFru8PCrh+ZT5hFI6KKRAiMQ5TIya9pUAKmDMHewD/2RVpehr6FRtchudBO3ZaYpDUaDJUbBpwXoaJt8qzy8ccohbQ4oNO6e9/9iXdFhS0LNkPMAD+S1W8XucHg8iPgGUxsgl34uVttAsqH/+8ynBYRE6OdUoG0A+Spl7Zo1uDiSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KVRiUBJN4S/v8m8wtJM6jbr7T1+ddRUA7B2b4XERUZCF5LV4YWcC3iLOYDR8JwjE8ZP95iPhf4zAQAUELVB7jOShiAgWSekvQHQNTCHXDDper+UIQ15kHP/wF7l6+W06o87rNa3xg5DYdNWzc0e4qPEh1OCxgcVt5w5T/rJlEPc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5885.namprd04.prod.outlook.com (2603:10b6:208:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:39:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 09:39:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/7] btrfs: replace BUG_ON(level == 0) with ASSERT(level)
Thread-Topic: [PATCH 2/7] btrfs: replace BUG_ON(level == 0) with ASSERT(level)
Thread-Index: AQHZOxV2pwRZhMimiUKBHHhwxdAKHq7EzEwA
Date:   Wed, 8 Feb 2023 09:39:26 +0000
Message-ID: <fa632f8e-c2b3-d6aa-8c49-1f131d4c5f0c@wdc.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
 <c32e735843f82e6348877672218abe529d5ce585.1675787102.git.josef@toxicpanda.com>
In-Reply-To: <c32e735843f82e6348877672218abe529d5ce585.1675787102.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5885:EE_
x-ms-office365-filtering-correlation-id: f8977a18-9974-4ea4-16c2-08db09b85e9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3CEzPvBCyMtVJxTx3DqMeOMZdmCR8UQp8FZaVL+e2ZI4NiBq9coab/wPOtF/u8kQOWsiAq5Dr2Hj2LGOhSSKkdCjedjd6BjjW6pY/qvgjXppYipSqVysp2EY+b6X4trnzid68d1u2ehsVOPQWu/6oN7f8PCHDgKgs6w4B+K3g+zyxzbyidql17t0vlwDfUYfdvTQUXinjeuuLU4LXDOUzz05rIZIV/TANpGetS6Pcu24IuQn15Av2WtiCdeBzyybAWJ7E2UIUwGC7AGkUkP4n0bAdGlllN2c4qbX/10GvK9Fw+VXXv5/744sKb4tg3DbFidy4FBXap5gquzaELYkZToyEK/5lpEskFdv0v1c58AHE/aDD3OrsTTxHiZ1OI5ys/d95Lc69al5RZ8WFtk5vvVSY+fvlJhiKEyCcvglt+5bU48z93sLF0lYiSV+1zELVrWSPj9uISW3KxJ6AbgvMjjnFjohnzUMxKkOq8iXtgRBHTNhY6lRrHv4vD+YhfVYT8m/1nSinNENTlkhPCUY58OlnwMxB3RZWuH5opIwyR/EIRqkhQweoW7tvn9ORMgJ2E9P8io6vTjqlcmoKcV1JbSI7le8PazyuUMwyB2mQCEhp4EdGJyD09Jg+Zb7knGbwOBNlggMnZYUFIhm79PC9I40A1pnu6BtL4OxZyXoWHIWpi/qe2/Jm/TFc6P4ebcUetmdxZ906pQ4ZIKmEXus9UdtC83qaAQsVuK4NmiHWZxc4fT8adO1LgGidIKHqFG/Bcei2t4uEvqerGSuTWVfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(19618925003)(41300700001)(36756003)(2906002)(71200400001)(122000001)(38100700002)(38070700005)(6486002)(478600001)(2616005)(26005)(6506007)(8676002)(186003)(66946007)(4270600006)(66556008)(66476007)(66446008)(6512007)(64756008)(316002)(76116006)(91956017)(558084003)(86362001)(31696002)(110136005)(82960400001)(5660300002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmVwSGgvZDRaRllBRkxKRlpYU2dHdU9GTUUxaHFVbENiR2JGakJpTnovTXM2?=
 =?utf-8?B?V25Fd2hBWWtpalE5UXcxVFIydTdocE5vWWl2SGJYbnN1UmcySGpnaU9KTnI0?=
 =?utf-8?B?N1pYcGJkVURNM2s0Y0Z5OHpMZnlZVjI2eEVSVWp5VE9ZUVBWR05UU1NPM3pu?=
 =?utf-8?B?S3hPWk81R21LYmdyTEMwZ09jSUtrRlEzaysxZWVjWWtPRm84RExEeGYrK1Vx?=
 =?utf-8?B?Y080VC8xajNLK2ZBaVhNVjJyQW9VNTdyYy9rMDUvMGg3VEpSTWpLMExhUnZs?=
 =?utf-8?B?WjRvYXppbzllWDV6SWp3UEZianp1bjBSaFY5YjJTV0tFQ3BMQkpvOWtTNW8r?=
 =?utf-8?B?Z216YUVYZnRJb21mL01tY1VHUE9iczF4YS9qM0kvYXlVeFAwbEZBOHNWRHVr?=
 =?utf-8?B?RHVMUGRXbW0zVnZYV0x1dTkzYVpVNEtJdUNzMEtNc04xcXVFeURnY2F3ckVN?=
 =?utf-8?B?ZlNjU0daRnVGTHE1WHM3aW00QkxZK21VYnM0N3RXZStSQnQ0M3kyK1h0eUJ3?=
 =?utf-8?B?V1k0d3VXZG1iWFlITmF2VE9HOFZYb3ZVd2xsMjFCbEhON1BnaFZYczZjVkJa?=
 =?utf-8?B?eHZ6a1p2MUhMUnpHSFF2UWZJdExHZWhmWUM1dU1MWUZJY29Mc1d3SlVtNlU1?=
 =?utf-8?B?T3VoR3NsendsK000S1FGa28wMlZSM3U0S1FZeDBNa3QyM1dnbWc2MlVDR0Y3?=
 =?utf-8?B?V1g2SncxYkJUU3hucnkreTdmV2ZCS24yTCtJQUg5aXhoYmx6ZjNDdHJoV213?=
 =?utf-8?B?UmtYN3ovdm4vT1N5NkNwd3N5MlRoRllHK0FacVJ1S09zKzBNL1pRemlPQ0dz?=
 =?utf-8?B?aStMMWFQVjRYNk1kK1VrUlVOZjFzUWJJZHlxa2hJRXJkcnU1T21jR0FvalhE?=
 =?utf-8?B?dDN2SUlaUndlcS91RHZwcG5NWGJlb1o1L2xLVmVpZzNuazRaWUp4eHRQVUN6?=
 =?utf-8?B?RXVDNW5zbmZxdThHR0s4cm9LL2JXTndQb2RmVmRHZHhpZjVaT0dIQUh1Titr?=
 =?utf-8?B?ZHRDaDdrc0k1OU1MQW9YR0N4T256dWoxK2MwZ3lWWm1MaUsxVlNndSt5TUYz?=
 =?utf-8?B?M1BpeGZKbkpGc2h5OGZkbnpJUk1Qcm8zYTBaWjM1MXQvVVR5SGM4L1dxeFRm?=
 =?utf-8?B?YTEwekpGd0FyQmdEaGlKaEsyVUR4ekRGRVRkMXVQRzhsenZUNzZ3Y1FOc3gy?=
 =?utf-8?B?ZENGRFZNREN3eTk5ODBOaEVweGplaTh5UDJINGtRUVJmR3ZMbmtEVG5MdGNE?=
 =?utf-8?B?NzkzaFl6NHA0aW9PcGFQaDk0NUxaWnV2RHFFNWxnUFNhdGRzb3UwaVF2ZnVh?=
 =?utf-8?B?Wk4wbG9IazBlNm5Vc3hIRGs3V3J0dmpjOWQ2QjhFbzc2V25wQXVRTjVhdWlj?=
 =?utf-8?B?RnJkRGNyUTFONEdDcjNUUVdPRUhXaFZpb2NyNkRtOUFyUzhNeFFKZXU5Q0VP?=
 =?utf-8?B?QUdDWGdKMHRKOGNZVmRDZm03c1dlYjhYWVhCMjBMa0w1Q1FWTzllNW03T2Rk?=
 =?utf-8?B?SmwyK3Z3Q1EwY2NpMHVVdFFndXcvWDBYOWRTcFY2OG1YYVBxc09Ebk40ZjRN?=
 =?utf-8?B?eWd0QXRDNlp4OU9FS2k5eDcxNTkySzA1OUFDY21SUndNbFVBSG8ybHdoZUNQ?=
 =?utf-8?B?aURDUG9WclVoUEJYdFkxZCtGR3ladWNRYXVVNXRrOHY5WkxDbXdjQVNOY2c5?=
 =?utf-8?B?V1RSRFFuSWZxTlc4dmZFSTgvcjJwUUZhTFM2bkF3bHJwYzEvRURSeVdWdThx?=
 =?utf-8?B?ai9Gbm9ESWhYSi9JQkNqSnJ5c0NPR3I5ZTNXd1pkVVlRbSt6RHhQRS9pVTFU?=
 =?utf-8?B?cVJqeXZUUGc2Z3ptMFJEendMa0V6K09wU1NxcEdaVDNzc3ZiUEZLbVh3RmFB?=
 =?utf-8?B?RXA0T1BJZm0vZ1VQTW40cmgycmsrdko5TUV4MVRsWTZMbHVXWWR4WTliSklt?=
 =?utf-8?B?UkxlYXNnYll6bU9OQzM0SmlxTnl1d1BFbVlLV0lKSWUzTVNzZGptaGlVbmVS?=
 =?utf-8?B?MmtLTjk5SlhHbWtKM3ZNREpiTlg3WkVFYXZ6U1Zta05MYlIrTHl0UUJrUjVY?=
 =?utf-8?B?KzRnWFpNMTFCKzhsZjg4cDRQaG41MVBRQlVGcm1oUWNsSTlPRFk1aUtDUTVD?=
 =?utf-8?B?Y3loRkpSeHcwdVNRUGszaHQ3Z1BnVEdUOHYyNGZKajVBZUtzV0hoWGpPMDdO?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AD67F0AB48C948AB54E52F4E6BBC58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tOU/JwqlEubkRpkmlR6v38k3qpJpyZgpAyXYukrH/aM5Hx73jql2s53X8Ihl9RbbGwbmVKGl4FIqB49v7B07aMeaNO2/1cEnFR+vL+W/fYbUqRdDWdH5WGO2soT/OdZ+ne+DC7eYlSid1l7SQJJIiJSNuOR6LIUVTyiwwGt86UWoPd+T9/oMke8KeArKqKshow9QUvDMSkLpfVSQYPVeTfrgVx6oIcVXvrhTjs7uSHfbkyVe5DfR4xBU20wBea5kBJj6F39+xODt/+6cLDzXQKgn0uOAjzQgpHnRyX3uJfFlmStUdRlK4XJFPExJl7DevYTchHb4Zp/MppVVkojzHWjn2rV3bjw3V+gwjKQv/Jbths3qYNXtuEDbooLPVdbV+sA72RvVpJYVL+wCdnrA8O3pm/uqZsxuDhyiwRc5l6n0c7dsnuLneSwx/lu8FEJ0R3UgHrnTZ00BKNe4JPLQXKuOMkR/a7Y67dF4UgNHPa95oyJjiFjNDQdo4Xs+3lG4aZdlCeOFz/R8d/bg924Rp1shrcheBQTf5+450RBy+gmZVNhoOKgDdPHaduRyAn+9pYXfVSrtYFNlDT+ZuvggxQ4rRI5/BjYL3dJtqZYypONa7ny27FqXghU41kLbYqAlk8URTGyLUpc8kJORb7ANZt+d8nOROTOWtuT5jJsdZ7E4f878Dx2sJMmulR5yldgd04GI4WNTg8x1q/cU3ZE6+6Trnq6g0jzj9V6AUVIYhhdHHXxIqOehbPqhKPmQEQfyv9aloQy91zEEaAVcWsnHBPXlEonomMbNzv/NL67aX13lRSbmY0uobiDqG2UaDGG5g/8Cp/N4zYqGnFLuA2vScA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8977a18-9974-4ea4-16c2-08db09b85e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:39:26.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms+AZKYzsNJcIiRKRGpPPnX5+WdOW3pr+ado07WNGIIY/RY7pPbDmdk4o129zUsMHnF5DCDvR469eelnSS8sU5OeQq0yTUJOJGtXIUN/Raw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5885
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
