Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436356C7E7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCXNK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCXNK1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 09:10:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D422A0A
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679663426; x=1711199426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AbwZVlmqszibi6oudmKZtXr5DR3n/nN3AkiLk3LczpM=;
  b=hFnY7DKT5seFz1zegJ3Ci8zPDwRYruK0CDUKtWGNhCejUQFqHUbnZNrT
   xVeFq3+gqhx15kACQ2JEYa3E1ASS24GcyZH84w1x3AMxWIs++Ck1ti7u4
   k4tpLDcFVFZ6hXuMCAT0Dr/TtPVDPGAsOJoYVn37zvrJxaOlThlCEleaF
   B9585/1Tv41HyKpUOGSeutAbTyyFhoA+U9n7XMcL/HdkvrunMCcDdzYYk
   0afqIEPIEyxP9CrnKzB+0+Azl0u/V85QOlUSCCHssJixIAjnrMsry0lL9
   S4zXPjDuwgfA83PTewjMwjrgQ+uBrhlHAX3G6uTXQwci4WmcIYLO98zyT
   g==;
X-IronPort-AV: E=Sophos;i="5.98,288,1673884800"; 
   d="scan'208";a="330847603"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 21:10:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBHdAF4ZWmDoWQD0+BH0e6exJ/Uxfx8WPaogLVuNP7c07Ceo17pUZhk9jhb1mWDxr8JoWw7db4Ci4qmK00z4zeYa2vhZ36F8PP0a6KmFdvBXQK0fGOp5FUFX3lGYzfUl/9RjFMj8k0BM4ycO/MH9o8daKtHymX349JS7JFY6A/fgs9fqC6msZh48AbP6RyQs4WyluQ+NUomIqgPKgF0pMYhTHZE0g9dbJn3C5aE1Zd0HoKSKb6Gjc63Rlf+9m3NXpzRKGzFZl6MJPLvtwGB69Wv4qxvsS4LvJMfj3J/iToIGSQv+t69oVVq+j5w+7mE72oc8+XLeCuXiTbuu4eCgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbwZVlmqszibi6oudmKZtXr5DR3n/nN3AkiLk3LczpM=;
 b=GBmZb+lD+t+YfdQseAMd18Szv3QOHwj/1jo9vho9wu29ICLTEzgTrPIpVp+5oBfFpa3anVEJ8FWXbAjnGrhdBENJTxqAptK/5dKby6Jk90PgxB2IAjL1rDBuu0MANBHYSohc0cJCTgAF6SJoZqZCgHiSPv5oOc1oQW71Sq+u1OMhZQ7a//OYkZT8qwCoUgFjQct2EyxYx22rqtdBBlS0lOUsVjtx3GuVoqWfdHxq/0OoB2/LTH/Q45KkrfR+OJzyDQJ7yMn02RPDl4qMPy5rhuohQgGuK/2Pz8lFYRwQZ/0rGV0jNPPb4evLBJyIQKMGr6TZVqmXEPDtoDFrJDs1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbwZVlmqszibi6oudmKZtXr5DR3n/nN3AkiLk3LczpM=;
 b=HVUYoGHM0tNcfesWDjoKUIstYA/Oy86BEw48dZB1S857i+AhOtVisBA6B6C8XMvy2CPr5CQJyA4LmWBPR9YujYaP1yPDC9yK+eJ6acRxVkLz38zf+Im+17xeHSwGqYd5QWdl6iymxmcNr5A19Ee1wJk380ce0F9kY5DyTs/dqFE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8112.namprd04.prod.outlook.com (2603:10b6:408:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:10:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 13:10:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Boris Burkov <boris@bur.io>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs: fix corruption caused by partial dio writes v6
Thread-Topic: btrfs: fix corruption caused by partial dio writes v6
Thread-Index: AQHZXfjdQrQxDdwoYUyaQkj3W+CSLq8J6AOA
Date:   Fri, 24 Mar 2023 13:10:18 +0000
Message-ID: <8d44aa50-d056-2785-0981-1535a50a4bcb@wdc.com>
References: <20230324023207.544800-1-hch@lst.de>
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8112:EE_
x-ms-office365-filtering-correlation-id: 41337e62-4d57-468e-cf8a-08db2c691de9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KIY++kA9cWjTDDHjgINgjts10rufmAOVjwVLvGwhoTFlvg+bNIfKn91Icti1bOcEAEpBHIhQ/KhhPrdmg+kj6Xshtd3K7PeX2IRoGzLmG/Dmls8euN7ZQDH3168Z3BveU2aY21WMUiuaEU+JRAUsr11AjC0TVpaFexdcohEHyWPBR23rLAJG0yvhRJzQ71en0NJ4bq/B5GfudgIfKyJa0PT6Kk4NN56QqA56V5UjyUkiSypSDAmxPGgSkEL+LFQ+WUin9sa0mWHmVNjFnApk1KaWofy+jfZS5HgCp9diL5tGM+GvyO2zopozPfx0iEzxcupsNI38fDL0+1SNCl7IgBVOzCA5Wxu1wavOoD0IvhBUUixlPWEYGNx2QZKqkAeKHZsbf7EAp0W+9wKTZoQzudFdfvAu14aJ5U2Hp+gGNPPS6s9YxuyuxX25vT1uiVg1CAUSlKqacgOYeQkui1jRZcemDNkzp793BVMil3kGubsFhJm3lKTafxuyrKG/CTCG1PQUbUONUX0x57M/giraAYr+PCuJfE3a52yH4gU7kHarKW5QfxIb/aM2ADguo7t8fFyfzg7ZiUZFp3z1Ze0kg/qiPDz4KnhfzZLEEDUAcgtwqCLdjiHqFkYtHVZz92GfrURliRSPTfMUoHNBwD9aoIWZXmUrB0HThrVcu98rxf2ybBGZQR6VvmYorZEd1ZO1cgH47Wnpg7PahhAmMs+LNmBnDFkRzJFdqBb+SSrPJlFDM+lI1q+v+2TFeyqvMrHZHzSyUhkx21aMI2L9N3I5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199018)(31686004)(38070700005)(38100700002)(2906002)(66946007)(478600001)(2616005)(71200400001)(186003)(66446008)(83380400001)(6486002)(86362001)(36756003)(31696002)(316002)(54906003)(4326008)(4744005)(66476007)(8676002)(66556008)(64756008)(91956017)(110136005)(76116006)(53546011)(6512007)(5660300002)(8936002)(6506007)(82960400001)(122000001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2lDcnMzTmkvSkdTaGZvNnJleTY2cWpvanRxM3F5TWpKU3plU25qNXlOTk40?=
 =?utf-8?B?TktmRG93WkV4alRwVkRRdWhidjlYQ1hKWG1OL1o5VjI4SHlwTnMxRmg5V3Ny?=
 =?utf-8?B?VDIrVFRoZTVzS3FQYzRoY1BKbUlaUWFscnovVEg3UjBGS3NJT0htRi8vTkR4?=
 =?utf-8?B?MFI3aGp4RnFnUkM5a2h5STkvK3VZS21lbDZ3aHlvODBWM0EzVktpYkRmSk5Y?=
 =?utf-8?B?T1RxNXlSZVllZ3l5UXhGUXRFVHVFNk1OWGNZVDdMVkUyemJiaTFDRHlaUldV?=
 =?utf-8?B?MXZkdWkwTUhDNjR4RnJtZmhwS1VyUHFwUUEzdGtsQUp3S21WdkdZRE5OcFpY?=
 =?utf-8?B?b09qT2krZUpuTWhLbDVienVsZXVNQ0VzWmFHT0UvU2xIMGVOVjk5aGQvYUpZ?=
 =?utf-8?B?WDIvMEg3eHJFbnEvU3RsVndXSlVtdHIzQktYdk9KWHNFd2RTdFNOdkMwSjlE?=
 =?utf-8?B?ZndFWURPdHkvNWZzcXBWZVlUNy9wZFN1Wk5UaVNFbTBkeWQrcnhRRVUyaW4x?=
 =?utf-8?B?RXBDRy9QRlFSZXVvcUtEd0VjSnc3OTh5eUNWdWw5V1BacmlxamhBQVFTV1Fq?=
 =?utf-8?B?OEtudGJ5NVkxbTVjUkg0bUhsQWg5aVBjU1BGYTJpQ3pxRVhIL1I0S25wUVZK?=
 =?utf-8?B?WTlFN2p5NFRGTFREL2lrWitRTVBVazVYVkdXT3c0ZVk3NkF5N2pLdDVQdnFn?=
 =?utf-8?B?REtiT1FpVzJGVlBTRDFrRFJvdGhBNlZVM1hpQlZNYWxRSnIzYnZodGYyYit3?=
 =?utf-8?B?YVJtdUdrWWFOUjV3TndCOG5oZHNSdzZoZnZpWnE2UEdDZU1SUWhBOEE2RHBn?=
 =?utf-8?B?RFpRb0dObjllUHFNNW9IUVRNSVVwQVJFajRwMlNjdk5IMkFpcHoxNXRvRzlH?=
 =?utf-8?B?R0Z3ZUh2NFdYN2xKNjdUZGMraG5mR0MzV0xOMEQxNlUzSkhnV0d2Y25qeEVZ?=
 =?utf-8?B?WDFEQlc0WXpISXBIeTdCQ0poQlI1R2JUN0ZKOXQ1UGU3L3JlblBZc3F3Vm45?=
 =?utf-8?B?ZDBUM2hlKzA4OFBkTE9zYVozazlYVnpSYTFRUGRNc3UxK0Z1cGdKNE1EOElO?=
 =?utf-8?B?Q2VDbDVVc3U3eWd2d290OC94MllFRGZlQ25PZWk2aXJHbmNrbS95Rkt2R0hu?=
 =?utf-8?B?MHZ3UDNaTXRmclBld1JHdFJEREpWcVdZNGJudm9pWFZ5SHdyalhDeFpkTk5p?=
 =?utf-8?B?c0pUZFR6WEcrZ1hmMzlRNzdlYnNBUzBDNWFJZ05xNk5hbWN4QUFaSEY4MUJY?=
 =?utf-8?B?UEtlL0tYam9YV0RnY3hGT01uUjVSN0sxYnlRdSt0Y0c3VENIMFp4RkxZZnZm?=
 =?utf-8?B?YVlkL1VzN25UT0pFUlZQbjVOc2c5Q0NyY0JYVUVTZnExR05sdUw3VlZSak1j?=
 =?utf-8?B?aEk5ZVE4MWFVYjBCN0JWZkZOWmN4bWlVY0lHQTQyaWRWQmR0Tlh0OFgydGZU?=
 =?utf-8?B?R1hKby9UZUZMcUpvbVpEYi9OamU3TWdqM0REb3BGSkdEbnJrY3FVaG9oMUVZ?=
 =?utf-8?B?Mk9XbjU3L3ZYbE1hd25veXpRU1pNVWpsZTZZdFdaemZNSWsyUFNERjlNSVgx?=
 =?utf-8?B?QU9MZjJ2T1Jja0l5alBIMVA0M3JhZ05mV2FGYnNGRWZ5M3FVc25EeXpMcEVL?=
 =?utf-8?B?cTl2Z3Fic0xuMEFrckZJNlRwNVVCTFZPTk9FNnZCWklRS281M0ZCR2RXZ3Vx?=
 =?utf-8?B?SE1QNkxJV1BiMC9uc2pwUEpXazU3a1A5NVF6Q2huaWFRUDg4b20xRS91bE9k?=
 =?utf-8?B?SWl0bllKL05la2ZSM2dJZDJsSmxYWUs3ZWpLdXFabWNqSk5ubVg2bFVGQWJU?=
 =?utf-8?B?U3NiZlk5NTFiSjIrSWZtNHNpL0U3QjYrSlVrS0NRSExqTnptTStTeCsrWEIy?=
 =?utf-8?B?STZJNXJnSDJMTVVSSng3QXlwUEsvZTd4bjJNWkJMbTh2cEp1ZWpiQnduTC9n?=
 =?utf-8?B?RExsRC82ZWxwdTFUQ3ZnMUJGK3lpTXpFck9pRDRNNlF0cVgvcUxMdzFoY0hY?=
 =?utf-8?B?T2JXbFUzY3ZsQUhzSU5CaVpBckw1YUFSRldEWm5SSlVlVTdXVnFKcE9EZ1Bu?=
 =?utf-8?B?bTJud2VMQnQ4YlFwTVpSVzgyMXlRWUZxQktrMWZqT09ianFnV0dycUc0OUp3?=
 =?utf-8?B?TnJPRGdTZlBOb2NqOWxia2w4OXpNNnJZSWtVTTNhVDJ5VGJoOHpLRENZMit1?=
 =?utf-8?B?RWtvVXA5cTRCM2p4SC9QZTNQYlIvTVZFckdlL3NQdnBocy9MaDNqMDhncmlZ?=
 =?utf-8?B?dEluWXZKdHRoaHBmS2VHc0F2ek1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3F234327464F489B7C81224C920131@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hr3O/uJjQ7nAyh/3cQwTvw3peVr20SjNJ6Hk9aWQiPmjAmoyaGjGu69FaYUICL3hlqeDH0OrkCScUI5IMBcmTYLrKmyup66LGT4orwgUyLtgX8cxewcP3ekYYUniPYSOGukBYIh5z2q8Yb4414sXnBYcbsJjeQmD/72VnvWSNc65cAkOTusuBOFa1pa2QbhewB7VKVjJruFNVXue0aGD7LHiw3+l3zMMMonETb+vF/if+cUguSYOogHgPNPq3AoVOyIYWG/q9XJG0Iyl0aTRjT9RhbNxQhGQvRk2QTwiB7YlpOZevR7Ng4tKb7f8D6Sr/m8QOvihiKg97CTXm8qVTHO8QDeoR8TWiV1hddiNp2rmXXktaCmUYgS0sa3w+324cb3g7nl2oMHBWBAkUENIuE3rZbxkXO1ULOjTN+9sN4KFYWAMeJMKQ8W9wrm95bu587TO3zUMTs58tU6nUq2n8pmh188SzzYm2t/Xi057AL5OY5iT7qY63St1Wgo7/9iMvZt79kG+PSPsWX2UlXdTarNbqKDQe0LurKGhXvfN1XLwEP1ABCYSLaT4KCFkvBfq2lccQ7n6oYOJFdrdbJCaDVcVUBObKeVEngGJeLT4GVUfbfYc97rnDXeiqJ8QCTEudwENDW2QcXS7lxojKkIY5VP7EwHNqZkazpU5NzeuBJPsyqEQvhqlUdNsuwrAPwUJtNn2PjA1QSvyvq/RwzcGRy45o6lZ0Dj8qSlsXX6R0OoGRtzex65zWbmhTTZF0wUmTyPUqaWZ2qTdo6JWE2WrRIlsGpvMpFkIBJm8Ce9eBM+oD1LEXCQ1I8VFW6DE2VMlQlnd2re45OGDzgKjhgvOWYKMh4MtBU9meP5U0p3e5hy3eUlEwKFeoURRR7EjpXU6CiccGrzX5mRCbWMLg3bRMg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41337e62-4d57-468e-cf8a-08db2c691de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 13:10:18.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +s1WzOVOqXmeP0J50SHjss8l+J2j3N/JnlRBlWn/ayPhE2M4dm7MGzXGOcbZCS7J/Ro9F5hcwcQVjcO1i1/4lVQVr+qUIrsXqU3t8uEmXW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8112
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDMuMjMgMDM6MzIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBbdGhpcyBpcyBh
IHJlc2VuZCBvZiB0aGUgc2VyaWVzIGZyb20gQm9yaXMsIHdpdGggbXkgY2hhbmdlcyB0byBhdm9p
ZA0KPiAgdGhlIHRocmVlLXdheSBzcGxpdCBpbiBidHJmc19leHRyYWN0X29yZGVyZWRfZXh0ZW50
IGluc2VydGVkIGluIHRoZQ0KPiAgbWlkZGxlXQ0KPiANCj4gVGhlIGZpbmFsIHBhdGNoIGluIHRo
aXMgc2VyaWVzIGVuc3VyZXMgdGhhdCBiaW9zIHN1Ym1pdHRlZCBieSBidHJmcyBkaW8NCj4gbWF0
Y2ggdGhlIGNvcnJlc3BvbmRpbmcgb3JkZXJlZF9leHRlbnQgYW5kIGV4dGVudF9tYXAgZXhhY3Rs
eS4gQXMgYQ0KPiByZXN1bHQsIHRoZXJlIGlzIG5vIGhvbGUgb3IgZGVhZGxvY2sgYXMgYSByZXN1
bHQgb2YgcGFydGlhbCB3cml0ZXMsIGV2ZW4NCj4gaWYgdGhlIHdyaXRlIGJ1ZmZlciBpcyBhIHBh
cnRseSBvdmVybGFwcGluZyBtYXBwaW5nIG9mIHRoZSByYW5nZSBiZWluZw0KPiB3cml0dGVuIHRv
Lg0KPiANCj4gVGhpcyByZXF1aXJlZCBhIGJpdCBvZiByZWZhY3RvcmluZyBhbmQgc2V0dXAuIFNw
ZWNpZmljYWxseSwgdGhlIHpvbmVkDQo+IGRldmljZSBjb2RlIGZvciAiZXh0cmFjdGluZyIgYW4g
b3JkZXJlZCBleHRlbnQgbWF0Y2hpbmcgYSBiaW8gY291bGQgYmUNCj4gcmV1c2VkIHdpdGggc29t
ZSByZWZhY3RvcmluZyB0byByZXR1cm4gdGhlIG5ldyBvcmRlcmVkIGV4dGVudHMgYWZ0ZXIgdGhl
DQo+IHNwbGl0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NToNCj4gIC0gYXZvaWQgdGhyZWUtd2F5
IHNwbGl0cyBpbiBidHJmc19leHRyYWN0X29yZGVyZWRfZXh0ZW50DQo+IA0KDQpJJ3ZlIHRocm93
biBpdCBpbnRvIG15IHpvbmVkIHRlc3Qgc2V0dXAuIEknbGwgcmVwb3J0IGJhY2sgb25jZSBpdCdz
DQpmaW5pc2hlZC4NCg==
