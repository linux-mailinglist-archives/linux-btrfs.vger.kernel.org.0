Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0106C3154
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCUMPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUMPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:15:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897838EA1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679400945; x=1710936945;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=n1qDN+lrGr8KduW1ZhLkyOVfDDiuXG7ZqqpwlKgdqw556XDi+ZNvx/Kd
   PmyUrhjUyl3udtYEhQgIPX5TNcHEXwM7VZ1PMlI6lHhGnUMf2QWrKuu0k
   llIGZ0eGUtF+XGcDp9HUR//4OQl6JOapUaJFJMtYlUlV5iAkf//ZjSTnP
   D2/BygL4cVO/AEfeFV/N3vBi/tbliFkMYGDbnS1WyDlMPEXu1o68T4foV
   47woJEANLqck85dftL/n4C4zBbthicj34c/tQAA6F4HNvZ/KJgjrryNMY
   uQRzeaNiGiGIUS94N/IU+C/yIQ7pEGnI+IzHp3xe+sx+avTry3v+lbhds
   w==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="330546274"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:15:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPVz0NQyGwoN4QPYOu8Nmwv7OjinsZLEHLKW+k3lxyIyUwY8IODUjFyHiONKVf497NPetv+INAF9TnSmKlHqNBTeumHxQu5/7W48aiSPKnO8qLfU58g56aGif5NTztN4mPhstZj8ZB18VLS8fHcDpplvsad7Oyh51p6IkNzRWr6ZYk6YOHz0fKz1Y1NBY9OeUWmruj/I0qGbkyV+VTYQMNsrHEXJDTESvEYK7x4+qoL24ubyuPdx+pTjeTrjH9aJcYq5M3XJcgF+YMRaAbflrPvZbo7K0S/jFDDHcKpU0MS8XivqNZuA1zrh/hs+dUixzlSmua1Zngp48Zg81qKOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Kzz0pI9RjPWEFds2cZiwDmYu+7pPJN/uORJujI17qVcyCeo4SO1ToFMGj6dMHZZGfRIzW8ASW44GD/4v/n0c5KbG4JhRTom9S3sKoO7jZeOCWf+OQzph0AM2Kc39pQQxnQJqr4SlV31jySE1RGRCup/c7iOMubD52u1Z4JRNjRuL8j/20t9fKmCWPMnXoDotjmKkW4e7SctTiel0R0A3hjes/aq1OYIHO7iI7T8lpDe/DxaHmtVBB+zKerwG8I65OmMm3fnPo6S/pESfUFywtNDzWUc9IjPq3LWx0+o8Ttn4OVADeYXr2LETTBTdBoCjt3LwQYO6nX8H3oPvyCkpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wHxm1jAFTR0DZZNrkw6F9ud7Vor5kzw6FubfCar/7IVo8kFntGMr5nbuL29TSe305JQCqeOsqhmALuy/iOmjOjBwZ9BsjZGBPcjUDqg3W5dy1sI1/nAoCP8ES4Myxi5OwyRhHZPAweB/kmcSdl4hyZGlw4Pf7iC0k7IGQCJWviA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6611.namprd04.prod.outlook.com (2603:10b6:208:1c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:15:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:15:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove btrfs_lru_cache_is_full() inline function
Thread-Topic: [PATCH] btrfs: remove btrfs_lru_cache_is_full() inline function
Thread-Index: AQHZW+l87wSTZHjwI0yuKTVWNVJ8Kq8FJeGA
Date:   Tue, 21 Mar 2023 12:15:42 +0000
Message-ID: <11d268ee-8728-181c-b6a9-65e8a5328c99@wdc.com>
References: <aa7f733f40ef92199f6130e83e4d88ca861d92f7.1679398596.git.fdmanana@suse.com>
In-Reply-To: <aa7f733f40ef92199f6130e83e4d88ca861d92f7.1679398596.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6611:EE_
x-ms-office365-filtering-correlation-id: b5d59bdc-c366-4b99-6aba-08db2a05fd93
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CauLmMJfqGsJZ7TnfnVG8dGoGdMnEas9oGhekls+t7B/PhOA+mVOHjiLtnbp7d7Z4NCrTN3gi4YnFRVsJBHVVkEiil6dVfoTdR902im1HMdSNrG+WJwZ4Cf53P/2/iY6lCW9lmEoTh5ABoi2EnimQb6BFAeLx/kRetyU6rGukc5NpRAqdAf2UuDgZyfM8K3C/Lb13z7ZpqChXtuV5y6AreD7d7Af4fCg5KW60ss4rOsNIvSufEj5ghZei9hNjB8AVILLbNLxCgwA/n4qAz9bF2Hx6/CYeaQ9aI8j5rGLyCTBsUhjZBs9t2ZO8SGm4Fbddre0tPPTfVOvyEauj0oe5yZAODQsbNOk+mPF/IIgfEa4FgdVhB/ms0aT7Ghz9IAD9kgiBqz+ajjs52s7mQ+O4MLRiWKhLiTc5jfVgKEUSz7tilSESC3Jyu0prkuMo0i+/aFIv72tx+z+fOd9bmiV/WkrpV9UzH6wumGm6T53EYdrFpOMgy7uR/pzpft97D9xVrptx9cNsP7uaLOviJ+Oer/CP2wBY+aXl1rpC3JfD6IpLK5qKu7JzRKcXTJyA5adDCPF2UaMLhAZG760P9H0qXRoHWmES01NAhJZb2N9SVEcsFydspFFUxn//yyBcjgAUJSfp66kIRy1RF1MJtPs/sc0ZvAZDE3LbZbIj10cHppr0B44UcyvJM4fZDO9yn2y6waiuqM2psx17eLfBBFKvvvZWXo6NOGpxLy3Bk4AMvGdmFBZ2SAmcPyg9RifHIaFTe7AvId4M/ZQ/An878Ql8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(31686004)(2616005)(558084003)(4270600006)(478600001)(6512007)(71200400001)(6486002)(6506007)(316002)(5660300002)(186003)(122000001)(31696002)(110136005)(86362001)(38070700005)(38100700002)(91956017)(82960400001)(66946007)(2906002)(76116006)(41300700001)(8676002)(64756008)(66446008)(8936002)(19618925003)(66476007)(66556008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lRZkxMVENhM1ZXQlcvRWpZRVE5WWdyOEhjNnprUnZ2TVQrTmZzVDNQa0Ev?=
 =?utf-8?B?cXFZQ0poZFR0WVRKUUtsZDdFS0dJSm0zZnd4aGREdVcvVHpvZGg3WjRtcEdp?=
 =?utf-8?B?MW1uWUZhU3pZU3V3ZXEyTG05bEFNUUY3MnR5clRsdVZSMDFqaDZQSzVKbks5?=
 =?utf-8?B?WVQ5WFZZaHpScVdTeFFuWlNDZHRkbzhjWnpXZnRZaCtzNjFnSzUydEtkS2pv?=
 =?utf-8?B?WWx4VWdta0xtc1YyZERFUUYrK1Bvai9hTml5R2h0dFBtdGx3T2VDUFBqTjRx?=
 =?utf-8?B?dFdGejJWVVc4b3ArWDFZYlNKTU95M2p4WkJqR2RhUWVocWFaTnJ6cXFkVGFm?=
 =?utf-8?B?U2FnL0ovUDB6R1ZKd2xod0dxdlkybUdRTlA1SHZCT3dNNzIxK0E2cWFKb1ls?=
 =?utf-8?B?UHk0RnYvVTRWM3lRUnpYeTBXb1ZsbHdVTk5YdGxVZVkzbWZTeUpyNXRhazBC?=
 =?utf-8?B?SXU4SEVGblFhTUtKQW0zbUppb1BmY1hqT1BldW9OczdkRnYvYXpXS0pSUjla?=
 =?utf-8?B?K3l5UUFQR21VNVJUOFlFY1o3T0VCbnNFQWRpakFRdUtBcTJRdzZNbFlIL1BV?=
 =?utf-8?B?b3ZqbWljS0hMV04zWmhMQ044QmZydXBKajZnbVdjeGl1ZjNmOFdZR0gyYk1F?=
 =?utf-8?B?bURKTURlaXZtYU5qWjlOUVcyQ2JNRHhaUVNENlFxRVhMbHM2OExXYXFyZS9X?=
 =?utf-8?B?OGhUc0ljb004NExmREtnRHdIdWc3QmdlVDNUVDMzNXdnQVNobXpiUmh1RW9q?=
 =?utf-8?B?Y2xxWWdJQlJOcjVSTFhkM1BuSitsNmN0OTFOZjZtbWJnVDROS2QzNW1RTytK?=
 =?utf-8?B?NUNWSjQvUjlWWEtITlFjQ21OdWRZY1BOUDJIaVN4UThRVjlkQk9ZRmdOejJr?=
 =?utf-8?B?MkpGVTNEbW9FNTV1ejNWbHZwb0lidkJPcTNmY3JQcWRZSVhhM3JKdXJFQmtJ?=
 =?utf-8?B?R05EWHBhUjVDelVLTHpnc3NWQmRyaHJweUxxNWpoYjczWm8xdkRDYTZjVkNm?=
 =?utf-8?B?bDcxRnJhdTR5bHhKWTlKbjFEMFBGY3B5cGRBNk1pWjV2bFVBcnI4cTRxbDJq?=
 =?utf-8?B?aXA3MDRkazlNZ2YrajYyRExDYi9CSjhLTnVvVlJlcHYxcmZISGJCclRyYStH?=
 =?utf-8?B?Z25jc09KR2RSVUJOQWx0eTAwT1VJdGJEVmFwKzMybUlwajJPRXlrcndOZHFK?=
 =?utf-8?B?eFowWUlvYkt0d3lnTmNCOE5lUjAxaFVOT3lHNDhMMHJwS2t1M0s2OVBMdWgv?=
 =?utf-8?B?U2lVY3NWeHFDcXZFcmtRTHJHeDlSb282YlliNXZocm44WitsREhCRnVIVFpF?=
 =?utf-8?B?eGswdko2N0YwSEhvQVNBTWVndkdNNEgvQ25semhGditLNDFOc1llZ3hJbndu?=
 =?utf-8?B?aW9MOTlBejVLUW9XZnNKZTBydXVLNDhIOGFZREpKQmp1U0dJcm5FRnRvVEdS?=
 =?utf-8?B?cld3SldBYXN2UzJGTFMrOSthVTBZcXpjeEVHaVoyTjA2eXdndm9VZ1ZuTGpi?=
 =?utf-8?B?Wk5aY3ZPMEpoTlczdGFwOG1WNTdicjRUUDBwN0t6bjU1REd0clJENXp0V2d4?=
 =?utf-8?B?eFpXdWcxV0J6SlVTOS9iYldIT2RQRUZBdUVNQkVzS2Z6RzlKWFQ3TDNRVnI3?=
 =?utf-8?B?Y0VnUzgxRE5hcUw0aFl6OWdESjUvUGgrNFI2TFZUVWlSZEZvVUgvUHFPUjFD?=
 =?utf-8?B?cGkvMXNkKzY1bE5ZQTd1T2lSYTM2MkdEYzNqZEFPeGdhU2RybFJ2YVdpSm9B?=
 =?utf-8?B?VjExcVNiU1NacFpoNkMwc2JoZHhBcy9PTWsrVGtHNVNhMkRlTFMzZXd5ZlIy?=
 =?utf-8?B?YnZkTGcwcmhsN1MweDZLNmRPRjZPS2JjUXFVOSsrd2VxTS9KcW1Jckgvbkk5?=
 =?utf-8?B?dXNrUEw1MUJyY29rYytIdG5ZRUl0OHJKdGh0VHVUMWRndis4b2xRN3NoVktW?=
 =?utf-8?B?dUJGYSt4d25icUg3MUlKWWE0YWpOdzZoKytXZldES3pPOS9iKzc5eFlvQ3Bi?=
 =?utf-8?B?c2RCTmZkaXluUmxZQkduWW9zYnU3L1V3c2IxZVZCU1dFVjg3bkc1Yi9rZ25J?=
 =?utf-8?B?VGNzR1U5UnQ2VVlwWllLdmsxUGZXRjNSbXhqNXlQVXlCZ2RycDZuSGxmRFJm?=
 =?utf-8?B?WWZWakRRVDNoaEZ6MDA4bnE3Vkt4djBwMDJSMW5RTElLbk9NZG9VR2tWeGRV?=
 =?utf-8?B?Z3lmYUIzVklHTmFnTHUrbWJ6VW51c3RDd0tsc052Y1pFYnovRVRUS21QSG9o?=
 =?utf-8?B?Skc0a1RqSVd4ZVZJay9PL3E2bGV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C29F8739E6D7458DF9E2F14BF855AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8O0+EyNbvUvvObB8q2tXE2xYJT1yTtUPywNcyvMDHYDnGNJCzxmEociryHSx17r+qO9CuCT4CiMyppoTEVNrm3lROBdB/fmj/DrKx3rV5eDbeJJ05KucVylOu5jp3jM9c0X61EUGwNIDakboDALeeLNWGMoqWvVF4k2QORgzCot+jHcx9FZnwY+nH2OhHOH+P7ed7sdw4moOTDD1VJFfTqOln+BJSinpRID+mcvImTvKDxIKPMny3fRJrUHebfyw6eEvDbGBR4IvV5xKmQzgGrCnCyj4jR++u8rA7+l+FYX8LfTEuxagEjtXq53A9BYdWpwBad/lMDqcm0w3k5Jksiz7KFR1Eal8sR8JfVVl4WCgcnm9fsSKBjR9kNhTjQjQwcJX0qeRh/bkjw2CqQkNrA8s+262j8HEhr8VrIQ+iPJIst5ySjxBgGSZf+uANBpIdm/5lIqO5xD5RZiKBf/sNjUcERhZA7Jy6ahSN/gkIathIJnZK/YyhJ9Ljr9LSb8lsBHR+I9hqA2j0d0CG0N+hJPzs0o2xFv6pOqkp4IVeydWdFnkghY5OOAeGEUq5fN+EFTiBemH7T0/4sg/ZdQEiqi9N3XhNAVrokNxooFk86B7tyO19c7kHIyQwOT/qW87Ek3aaZ49bebTLA5P1CFmObOfxbx531kTvWWUh4Zr1nIzAwiFPbLS/OizNwhcfkbOUPTBkcPmUbVpPniYv3OdgpkJU8P7PT6fFHpmcAIHbdvO77IgnWqZFHtP/bKpKWKfWyUcAzEkqmwV0456m6mwL7uKuiHTQayunC4LQTImQcFqPnZiPg0vhxHfObarfz2Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d59bdc-c366-4b99-6aba-08db2a05fd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:15:42.0244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6G1/vSMyUx6ecwYcbbtKwOu15i9YKjINMEMJq1ME65MsUwJmYyrHYlV+PMIUP4VEnzsPMcSWSmFmjI+PGpRhk+PQZ6Z1KIZ5QX5RQfsAZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6611
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
