Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDE6B2C06
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCIR24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCIR2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 12:28:55 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01FF7EDD
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678382932; x=1709918932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LjrqGaJJHpBGHWW84t5LxehAkOWLYgFd0sxsKjXBenOCMpebkfsTymfY
   mWQAdb77hQzLxM3iT5h9yvElQWSSACNXlKfTBvh+lN7ClSi/1KDJ/fn/u
   C+VJa8p6VIN43lyQ5to9aLtspW4IlIP/W6SLz6rXtlVyk8irdry4wCSVq
   gPFKUogaGkArcvw4simZCfDt4llFQZBwADUA3I4PHuiYHdGG3wGPlab8P
   0+lpcRrMwrn4Kv9EuFSNpg6ULACvBLXA6Clz0f1YWNtmsGoDk1tSJ4epc
   nhyiL7xQ/PRJG+tzRkIoXIjLr5W7+U2hQwWui/8B05zuJOLAQCEs1sIRa
   A==;
X-IronPort-AV: E=Sophos;i="5.98,247,1673884800"; 
   d="scan'208";a="230200089"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 01:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOrEZeSp3F2Lk81JUu4PlCjq15xTHedAlkj+uWt1q8JQe20TF/YCItBAj44WnaHzTvd8AiKpoZLm0BbaeCIvPHpU7aI5eYzMk0WuT3MV+6Va0OfPorydkWiW9QK2GoDgLpTg8NFeBUUkOKKXK0DEDmdXdDpVnshZmzkW26zkZXEv+yfsV1E0qyoX+2tqqQwwpaUXPO0wy1pvIb5WdhuvOcQTTDYZrNvZ76KoBBJzUVR2xrA1lmBhJgqI6c+YDMNpmsRquhuVzXH7Jg5Q3L3Qwhvb6xJEGAq+dlVO1PqHqL3cx0m3UodFOb5h2zmf0hk5AmlaAR9157jjAuiV1b1zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=juVC1+6CERDEx4FZMsG3KAJVo/zJL8W+Q1QgQe0Lv3ZQU1JQbMmIM0qXCsWHFDrRhLFZkEqm6rm0oRMikzssVpubTsCm11UtLfozBVj2hIU/n89XC4RlN89fwtOrhHR80cuhr9/BN6HDkbKHJuz+YpcVFIGagpjN/Iqv6Fga4w1q7z9zOeWeCEraSaqSW+iVU8bIyy8VCo0gVXJU+53qSQvyfc9r9NHDqnQmjLktEDMougiwmkgUbxeMHkMQTRyHfxCHJ4EZR8oN2gHViJDqtgfZLO6XYePYOcwCBKbirkEYcN3Jf04ieyGONkDFpv78QpOtDXQ07GQmZxS/iYJt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HxbzDFQ5/zJ6vBPvygTZwykrXGJ1KpxbfRJQSC3xhWPF1pFn0mP+sS1MgTzxJA3YQjEKtrpKCQzPi256PGtOJPbi5HF/U+dZYncPuHA9bQrn6oJvt12FsC5JGeeK3rp1PTdKVrOIhiJSPOjUuwo+jCLdayEXGnf/ccMSapuXZdA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8336.namprd04.prod.outlook.com (2603:10b6:806:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 17:28:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 17:28:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 20/20] btrfs: merge write_one_subpage_eb into write_one_eb
Thread-Topic: [PATCH 20/20] btrfs: merge write_one_subpage_eb into
 write_one_eb
Thread-Index: AQHZUmbCBoybjCbuCkCTDFOmrD5rLa7ytGiA
Date:   Thu, 9 Mar 2023 17:28:48 +0000
Message-ID: <93ca8404-e4b9-1ae3-1c60-f40a5d38b218@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-21-hch@lst.de>
In-Reply-To: <20230309090526.332550-21-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8336:EE_
x-ms-office365-filtering-correlation-id: d8c1f2fe-e09e-4aab-f4c5-08db20c3be09
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQ6BSmNvGMH2PPz9qROfPZtRwjs9fWbWtdVe8f1iHWYnaDvRq6NYR9GkS2hlio8ZbVpW4MSAOugSPEp9gAtA8uoomvuFjzzYL27olvrtMvZs0OqPiQtOu2xM1telNzsmJFchF12TiHaAQFLz3piY8tKro/E/7ctCqtOPsGbci2TO0Qy5obgA5Kdt2njHTME1UelJN0iNCoUmpT1GGjlp/VlTLJOFtnYYKsqDdBSJSBbuLE1Rzv2ygI5s/ucz0kXdMbUw409NTJ0XcbwFU3AlrLNBYKvWN+EtLNdX3k4THWc9ROVBE1xbmi1rX7LPYRfUVkicsu3QLMHu1sCKxlqgKZIyy5p+3pEr383Z8QzI5aPeM6/+mdc5x6yWafGQWC0XpMjvIKQK5ncVskcljWmOXvMCpW2unl4723aJp8slLbWsx+EYiiSt1R3+4brhWavbJNYUH7qplpocafXcqX3LxqT20jqZLfxy6+j3grg35qdiytchco5pBzMPFYkIk4F9FXNH2HNT6LYzaOT735rJ2VHjyDtMevNlAIx6KWMH8u5nADJMenQyai4umkX/79Vy9lFC80A02JCV3WDSm2JCxPGmg1/ubNEarLW1cUZapIjzMGnDKiW66Brd8Jm3JGWq/u3VvxlTA4vsd0TkYQeT7jZSUUx09pi1cBnMUOOQedfuFfX0bXcFXRTUTGjl1rMSVksOF49WndmKERI1PFvivFN6ooaurOafiNsWkiodKRuVbOlkiAwVWV/NxfLTbR6t/7Hld4uWUMcL8+9f/bmtGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(558084003)(36756003)(110136005)(38100700002)(6486002)(316002)(71200400001)(5660300002)(2906002)(64756008)(8936002)(76116006)(66476007)(66946007)(91956017)(8676002)(66556008)(66446008)(19618925003)(41300700001)(4326008)(82960400001)(122000001)(26005)(38070700005)(4270600006)(31696002)(86362001)(186003)(2616005)(478600001)(6512007)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzVyQ2dzeFNpMGJGYmZmVzF6cFdsMDJETEpSeTQzUVV4cDNtZEkwK2U3Qk1L?=
 =?utf-8?B?bzIzSjdhUVhraWthQk9yVUJjTFZaWkorK1l4VjJOcGNjbTU1bU5VRkRhYW5w?=
 =?utf-8?B?bCt2ZG9EbnNwTmU3cUV6RTJueWRWbitpOGxVTExIalpTek1rZlpKNEd5NVRD?=
 =?utf-8?B?VGZ1MDF0bW9SM2tnY1JPNERSaklUWWdMWDExejJBZmJOVUJQT2IrNUxSbWJD?=
 =?utf-8?B?MVc5Q2lUVjdvajRsMjU5Rk9GZGZ3TlhWTk9lQlQrWmM5eVkyT3prUlFJajYv?=
 =?utf-8?B?WkFVWnVEbmlnU3RmVDJyKzdSRG5mRGVKRk1LYXo0TVB2TFYveUFiTXFpMThi?=
 =?utf-8?B?aXdCNkMyeWdNU09OMG5BOGx6Q3VOTEMwOVAxR0FhTnhSa0gxTnlyS3YyZkpC?=
 =?utf-8?B?RUN1eS9lWE96cWVmM3B1WTJXVkRwTUp6K3N2Q3MwVVd1Wlg4MXlqa2YwOGlV?=
 =?utf-8?B?K2lCOFQrVFErcTZreU42azd1SjhuSndLTSsvUjBXMXZQWFEvK09SM1pwaTRi?=
 =?utf-8?B?bk9tWmVPSk94Q1J2THZkS3BYN1diREM1azFpWTlXa3JGSXJUM0JoVlEvK083?=
 =?utf-8?B?ZXB3ekw4Rms3MENkTWc4QjVGSlJwVUtNR0JuVFdIUUc1aXd1d3hBOURNdSsy?=
 =?utf-8?B?eXFtcUNUaFk0b2hPZ29RbEQ0Z1BVcmhUTTNrQzBuU21ZNjBYb0lUZnJ3cnFH?=
 =?utf-8?B?LzdQZzJYbStvQmEzYTc1aFE3UnBkRVBLK0xvU1kvdHdCY2d6YS9kQ2hGdlRT?=
 =?utf-8?B?WEc4UHIrLzBHSUcvR0Frb3I0L0ozbnd3VHhLM1hDam8rSU8yazFIeGdhdUwx?=
 =?utf-8?B?c21vTGd6VVArTWozVXYxRThMdmcySUkxelA4R2NQbzlEaGZ6YkZRYVk5a3dK?=
 =?utf-8?B?KzR6TkYxc3BZVFNPelVUWTI2QUFVSGxGSkJIUG1QVWkvNExDWmlhK051Uk1U?=
 =?utf-8?B?SzE3ZDlaREJ2cG9QVWthWkRqRUxTTFJBTHlPbVVSa283YlRPQmUwQ3NSaXVM?=
 =?utf-8?B?TFBrMVl0dVA5K1llMG55dURDY2FXNGFTR1B0QzBFWWlEN2dFUkgxWTZvc0Z0?=
 =?utf-8?B?ejBSUTBONmlGeU1WaDg3UndPbmJ6d2FCQnpKMEhuRjFsY1N1ZHh3WWZxTU5W?=
 =?utf-8?B?M1pzYWxuUWRLUVRxbFlNSkwrSFFSOHR3UnRRZ24yMmNXbkxybDY2R1VBMHpS?=
 =?utf-8?B?MVM5TmZpa085Z2NCaHkzOE0rOGRRVlRteGZpdGIrTEo2TWR1RWxFS0xENzda?=
 =?utf-8?B?ZWVqLzZkSGNId3BHTUEwU0JUditDcHlZN1FhRTZpazZkZGZMWk5PMGxQWDhj?=
 =?utf-8?B?Y3dQUXRPNXRqbmFSN0lSM01CbEpaVE9yZGlMMW5RQWdrV3RKS2w3c0huZlAr?=
 =?utf-8?B?MityQWo5RWpGWjNSekVaY1hnUW12RHUvRDF6VDJsc2xZNDArcGZtRWkvRk1v?=
 =?utf-8?B?NXFhRHZ2UW5QK0lxNjV1TVRrVkNiRy9tKzBSN2hWczJBMThablZkQ1F4dHZF?=
 =?utf-8?B?L3BobVhJRHovWGpYZHFiNFNxSTRJZXRJMFJXaGZaOGtuR1AvcmVzUDZNU2lP?=
 =?utf-8?B?Nm5TKzNBVXptT2Zkb2xSbjhoVVc5bmhWb2NneGxiaEJ3VEpDMHNleVFBa2w5?=
 =?utf-8?B?NXZ5ZjNqVUtXRml0cTVUT3hiUlExNkl0Qk1pSU43dnE2a1pkakJKZmRUZFRz?=
 =?utf-8?B?ckNNeTBXOTZ2UjlDOTA2R1BjNkhsK3Y1Wm10cnlPY0tGazJSVk8zeFB3REwr?=
 =?utf-8?B?bTBET1dKYk5iVmVibldlQ3RYN3NxeFFyWXllU1V1WEhJeEszM0FLODUrQ0M0?=
 =?utf-8?B?aVhGOGk1Nml3MkxLbzNUd29HT3M1eEk2dU1pTkxxRjBYL2hRL0VPTFgwQmd5?=
 =?utf-8?B?TG5xWm1mNXRyK0ZTdGd1MFJCSVFPL1cxMXNSRWl3bDdJcWFtM01QalRZdGov?=
 =?utf-8?B?akErTnR5RnowSUU3aEtiYjh3MnJVSWdhaWhSRlAxMStUU1JYckNSTkZCTWJv?=
 =?utf-8?B?YVVXQTdOSERHN3ZwbW55YnBsa2pLM3ZHME0xSCtTOURiMDQxSWpyVHhqcDN1?=
 =?utf-8?B?d2NhbHh4M1dGOGN2TzQ2R2lNQUtPRHRxQVp4eVhmZ0hScWkwOUMvK0xyM1lr?=
 =?utf-8?B?NHIweTNYdDFmMWZOWFV6SmdCckZGb3J5VGdFK1lUcm8yekpaVGw4MmQ0cCtp?=
 =?utf-8?Q?lfgO6K5Iu9Y+UJhzV+fE7ZE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49A9A302EB71D64A94F0312338F6BA2D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ieH0Qu+vB2u9ugQvHU/W22Z/xlXPbAxr3D8OvdC/gtQh1Pcy+Y2OT0RUoqmgKyyPjg4HWcd/2IFiE+97IeWcbhRDtBOAboGdVsDbCW34db1Avrjvf1IycHccHNyBKKiyPBdE/HZtP7Hit3ueq3x8oieagJXcbuQC0CpoiAJycRrWenhgM2fTO/IqbGNKM0sd8mcfb/vZy6Z9e8AOMOD9j2daBB/Lkw0PYP5DCkmKzCbvPyYxi67WmARCRMaORIiOBFYBy3PMVsXlt3hiqKbwsWucMFw3FhrSWkAoKMvz0h/tmLVu5dUPRUS3ulRWeOpxUi+/J3JYPyTwupa68jCULYXIJb6bXtpzFFxiRBXWscywBZnh3I6mrRgDYvyJNpoAYRHDUyC27RuNtvOAkys1JchvXvLzVIlDTmk2thZyUpIBdwHkvqGzdPP7vBHHgSfeYNbDxUL8RsbeIYKdZ3Vv+KLP1N/flW0sYFrZCu+gWQctoCP0A7SRTJevWB9qwKVeVsrPtps6LM09of8/weVzHGsklzDNhNLkq5I3qBJPO944a92/26rH53F1WL/dPlE42DSw0sGQ4F4KnZ1webR9zI2ME3OqJVPa2+bM6TaPzyApY/IMrDzuetQigvOnpZk48N+jq30gQhJWyPUpHmKqlkraSd1Ay1oPGwl0FPlu+xqQNllxZlzpvTy+YVGlHApKOZvvDliyOOgcZ3WoHsGVLNO+Xc2SsRmOWOQSDwMkvraQDPvX1JSHRFZyoAjkFEXWvE91FbMKC70q1/s0KhlieVcCKp0yY1JpSHeIufWBn4j1lN+upb1r6jdrIUmon/l29Ismml2Tkw+V6RjZScPD6rPCLM02LPWMCHa4NJBKbTJp1Pljtp3R3Nh8AU246yxJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c1f2fe-e09e-4aab-f4c5-08db20c3be09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 17:28:48.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //HwIRW6y4K8qFXJ+jg/o9/EjyK9JBy5ErGA+WgbNZGtv8Y8EL27XRPQuiVwXDb6UTSrnwL/PvkVZvQrey/hbKzdbzOiiYBnN95fcc0zGH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8336
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
