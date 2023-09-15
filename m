Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E477A1CA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjIOKqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:46:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A75A1;
        Fri, 15 Sep 2023 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694774777; x=1726310777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GYtKgigQBRC4ikCPR1ADKAUZYvdH6jww1k0LayepAUM=;
  b=MkCdKgZ302XppJ7HJCnTc444Zz2f/JgNmK7ZdlyLvIONmQUvOEFw4Y/M
   Fv4keYkcsyht+FEY7ipjDOxCtQhd9svTNWx3+mc4gHpUzwEh6bTT2uiHx
   ITFK8JRFKLOm8nG9lWK6Ca4w/tdrNoQeUpD5Z5X8Rf6US+3eVGvTr+j7B
   sxlgRoV740H+ebAWgKXXoo76IfXJGZ+Srrk+ZRqZxSrsSzroOMVYSJyWK
   wUEp//uJkV+eo+09pHvFvW+rq9GyJEPG+/p1lsN2PRxI+aZ7jKuKcFEKz
   rBCz6rGwHTkjsCgLLqRTUgtqBaCoCRdBtSsem/3usvxqYaRtr6h3CBYTe
   w==;
X-CSE-ConnectionGUID: BOj/AgEcQbSTr9amZqBePQ==
X-CSE-MsgGUID: 4coUPcV/Ty2y7zxXqUUjzQ==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="244053443"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 18:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTfOVvv7Yj/MqwbuU8N44EB0GIky+lSfzT3MQKlDLDfyDpCjtWXZDoocxxPEuyGvJy0jwvyG4pyQ5tjbb+Y9Ct0dtK8WuyPAoTMnb5eZytV+QDNGm49nvVzfq/9+UB0+AjpQFNckZCXQvhA179EL33CMVpcgdOx/V6GTZW/kxEEE+A/Or2byHcZe3fjoJVNj3jScmSmHAJm4g4plGarz7xBqamYj6VFyAUGmadFKcpNmnT1VtH2dmKrFLw+NcGLx4BQqE93XkIfcuVYcu/VGKb1OdguU0uNTxLHcq/K9fkYQ6Xhh+0xEoORpBrfNrQBiaFT2wO0VCbvzgLHnZxkrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYtKgigQBRC4ikCPR1ADKAUZYvdH6jww1k0LayepAUM=;
 b=XIYum3FhnEFNKL8XrHm1+riBPvEyq14s3HoGgFTZx2cWx2BMmmSy6AeTSFacMKDpAbxhphMs3+EeYmD+hNLdj4/VIj7fzN1k+TF8doGpwVR/uJQH9q6YX5tVD7npbH1CgYqp5QW0FlzCqQ3EwAZc4aOu6duiTgFAn/+MZPt5OwpEwATsB2g+gkqgflRur/JmcqJhqsN3tGOrIaEedRuTP8ofRJx7G7bnsE6gWMNsw8HwRoskZNBHYt8gsbVqym9voOq+w6ZHy5GO/j49QWptavhD5Grm9Kd0VaS9Lr/63DjYg+QsWdmJZf4sYACiXSpM0+5mrhGiQPA2aBgdmuM/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYtKgigQBRC4ikCPR1ADKAUZYvdH6jww1k0LayepAUM=;
 b=rFuq01VeJb9+CEpExOB9AO8h3aUM0cN+B7ZHrDNeOqhMvFvb49OCwaju9bQiaYNqCmZQpjAvyJMflz9/TubDijZnER+T4MSP7qkw2zaTpmxYrkbkmxsgLfXzhhOBnpoPqjRJF5NXuqSlynwb3xYXzY3uJIs0m31JF2ycFPZnTVI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8593.namprd04.prod.outlook.com (2603:10b6:806:2f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 10:46:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Fri, 15 Sep 2023
 10:46:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5yWFR3MOJvjDnk27U5ab5k1D2LAbBxYAgAABMICAAJ76gIAACraAgAADbYA=
Date:   Fri, 15 Sep 2023 10:46:12 +0000
Message-ID: <783233a5-dbf5-402d-9670-8e2a7ee421c5@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
 <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
 <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
 <c85e00e7-e9d6-40b0-8bc9-7d966bbd1026@wdc.com>
 <e2b069ba-deff-4cfc-992e-ad8e1d9b6f02@gmx.com>
In-Reply-To: <e2b069ba-deff-4cfc-992e-ad8e1d9b6f02@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8593:EE_
x-ms-office365-filtering-correlation-id: b2b6ec53-0201-46b2-5ee8-08dbb5d8fac5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07xJXRGJKpu+PM9ggcYZIqW6XJOxIEdbEx1HDXCd0D5T3LtgcSf/Pv95fO4VPujCOS2ApTQMhsIHUWxwUlAhMjHv+3ImEzcEFCjPUo6ed7QfTwHG5+yCceRDZs7rZbrR2uurHbNH4WHJrwcCn3VKFTWE8vEieG/49ikuYNts7Z90SN2lVijXWQjCTNF8GE5B8slf8lf6y5u2QxXmdktHsOjubIcGX7X/vBplRHsELN7q2j3/gjx3DNtfwLw6QqpUHGdhbNhFgTmkbXm/xMaZfEB18jMlTCXDXxgPYKVaRdzPHYCZdKWSBkln/znfAXFftunAYZozTHmuUm5ioZ6V0TtVGIS9b8SY2lOWa2Vx/8MqExt41uuNLY60cyiaf0MA/Q/tdKEFKBN4up+B4wxHojRoJomft0GJbpQNCRBQfdbSbZsLEqZWBeXiRZHadvztV1xidfRJPV7pdtmOXdN6i3YUIZ14nqDOVOP24n+VmI4lfYJqTU+bbKTbLlclGMZ8f1d5Gzln+RPW5i69b/NWEVqQ9aUthyytEZMxXDoS455wsxJmCUN69iIFONN++AJFPjpD8GaSC7Cn7nozuyH86QDVsvAZSyYBJijZCdMG1YB3RNFBWZolBffswF3o48xnS+RdG01UWeYnn7I3JG0TQlMjDMc9enO/1D/mODmiVOGV2FuwzcnzGylybKCbzfmy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199024)(1800799009)(186009)(8676002)(5660300002)(41300700001)(4326008)(478600001)(8936002)(66446008)(66476007)(66556008)(54906003)(64756008)(31686004)(66946007)(91956017)(110136005)(316002)(76116006)(2906002)(6512007)(6486002)(6506007)(71200400001)(36756003)(2616005)(53546011)(26005)(82960400001)(38100700002)(38070700005)(86362001)(31696002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkh5em1kU1ZFbThxS3RNL1NoVnZiZlFYeHcxdi9uZHF6QzMzblpVa3Jwd2Nu?=
 =?utf-8?B?Myt0L3FnajBQQXNpd3dKVUI4dzhsT3FibjFoQWxaa0g5TmlkWFRmQXZtcUpz?=
 =?utf-8?B?eTYvQlN3NFZyUXZxdjdZbk16Z1lpdnJ2ZzlMV1BNazlFeFZJQWp4TkZjQTls?=
 =?utf-8?B?TEdHWUpmYkcra2ozYmN3bXJKRDVzUkV4clMxZ3g1VWM3YitEVnEvTVFNcG5U?=
 =?utf-8?B?UDdyZzFTL2Y2QUNKT1V6T0MrNFh6bW14MEI4dGpVSTVUT0hPdFU1bXdhaGRn?=
 =?utf-8?B?Q0xkWTJ3dmtvaUhmR3dMMzNZUDg4YWg4d3pueU5IS1VndFhDaGd4cmlZbm0v?=
 =?utf-8?B?eUpERE1kOExjdm82NkRYTTNCc2VOcmZFUUo2c0YyTlA4Nk04M2s0U3RUVzRk?=
 =?utf-8?B?K1h3aDFoNFVIRTRsYkdVL2duYWhUblc2TzBZNFIyaGhKNlIrM2JqTEprUXdH?=
 =?utf-8?B?bm5WT2dkYkJIT3hwSjZPSmRraTc4NE9GVlQrRnl4ZUtlVS9FbThDZ2RxS2VR?=
 =?utf-8?B?YkhPT1pMaE1MaXNjSXJxWVFrMGpMaU5RZ3hLdEN4ZHI3ZUZxdGxqTXVqMmg1?=
 =?utf-8?B?bEwxU2V6WjFqdm5oLzQvTFRaSjdJRmtXeE12cDVXZUZVUENzQitZZmhyWXR5?=
 =?utf-8?B?NGtOemMvVmNHVUowNlR2c2NOdk5CZTNXTW9tNFR3djQxZjNzS3FXQ09neWVQ?=
 =?utf-8?B?MjJHSTl1MnJsVmhVNXU1STRnd2J2K2xZd29JaFA1OEk3R0lDQXduMHp1WGFn?=
 =?utf-8?B?V3FVVEFubnZ6V2VYSzQ5dlcvVkRZSzIySlp5YTVhcHVlRTVWVUplbDFvbFpL?=
 =?utf-8?B?ZVNBM1RlMEZMWUgwUkFzbjQvcXN3Z0tCTWdLS0xGY01DRHp2emJ6SXBLb2lO?=
 =?utf-8?B?dkp5bk00U3p3Q1RYSjZrVUx1Wnl1RkRFUWdOMXJTZXVBTzFsWE5BQXNIVXpP?=
 =?utf-8?B?NFVZdmxycTJFVDVsT0RMdnJQUUkxU21yRURuYlFYbk1uY0ZWcWtNMk1aYnhk?=
 =?utf-8?B?T2NHaXVvZ25aYnFvVHp1YmF0TFFiVThTcDBVTEcwUE40TnMyZFdGU1NLblRi?=
 =?utf-8?B?aGp2dnJweWQ4eDB3L0xkSFhhckV6QmMxdHROUnZXSFZBd1FPVzkrSVZEN1R2?=
 =?utf-8?B?TXhLOG9pODJpTVdPQldFNjFzQ01ZSFR6NFZtakZZMHAzVDJ6OUZHQXJJUG5h?=
 =?utf-8?B?YlluZ0R2Sm1MTkZtVEJsTnI3dzRsN1FMN2ZQYjZGOFJES3BPZWFFbkZFY3d1?=
 =?utf-8?B?Rnhlc1ZNWEFmUDk5aVlKSW45akh0YW5Ua2M0OUJOcWV2Uy9xOGxjT0YraXZV?=
 =?utf-8?B?SzJNQnYrUC8yNXBVODRkRUhrYzhPbUVWTSsrVmRYNVpGYkhCM1JjUHNaRTl6?=
 =?utf-8?B?TXNCb1ZTUEdzMGdEVVpWMkJEZGhPYTlqalJueGlmOXJSMS9BbnlySkZoa1pZ?=
 =?utf-8?B?NDcxMjg4M3JZM0hXdXordWYvVlQva2FkdjVVd2wvSStOS1BnUnlCWDIyYVJl?=
 =?utf-8?B?ZHJ4N1RRc1RTOUhzNmRXUlBkTG1tOUxKZHlWbVVaTjh0YjRIdWYzMDRCb1lo?=
 =?utf-8?B?RzBBTktpR1M3QnJXakx5SFNYdWhaSTAxZjBZaThMZnd5Y2o5SlVkUU9uMjho?=
 =?utf-8?B?L1VaWUlpRzV2NHRleG83WlRVSnMxRVBtWmV0N1VTNml2R3kvN2Y4WHhOYXZq?=
 =?utf-8?B?bS83V083ZjlrY3FWSWxuZWttUWpUeWM2SkRyRi9hNHNVMUV0Zkx1YWxzbFFi?=
 =?utf-8?B?V1ZlY3Q1WFJYeFR3M3ZhR000MlV6WjlnTGJ5VDlkYlBGWFNTTkV6VzZwR1dX?=
 =?utf-8?B?Ym9GRCt5UlRzYjRwRUNsc3l4MnlMbFZvb3NIVGgrYldtKzllZDlIUEFBN3Vq?=
 =?utf-8?B?b1phdEloNXBjM1RqT0hFbkdJdU5ENlFPeXJ6c09LanA3MzNpaW1takdqK09D?=
 =?utf-8?B?OGlXS3lLVU80cEhvTmFXekJzZ0t3WjV5T1RNZDdzYWlVdSs3QlRUWnhraVVW?=
 =?utf-8?B?KzdzZnZtRHF6UGF1TUM4MFZwM0pxOFI2UjhDeFFUMWt5YXdBWUNGUWp3eWd1?=
 =?utf-8?B?T29DVi81OUNBdUQ4UVJmZWw5NzZoblpsU29zVDZmbkM3T1NHRTBnbGgvUTJs?=
 =?utf-8?B?M2l6SE9TY1MzTFNvUmZHcDRhNWxjRWtoelVoMVJma2dkZmpNc0M4WDByZGF5?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E502602063F2441B912BFBC0A5B1FA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OG9vMnBiQkRObWVIOWN3SG1VcGZzVzlxcFp4ZGdxNm04dTVDV3p2dGtiTDNI?=
 =?utf-8?B?VUc2d01Ick8yMGlXZUs0clZOLzVwTzhkTEFNZXpvYVl4eEM5YzRTSGZMZjl3?=
 =?utf-8?B?T01VanlKMVk3Nlk2Z0ltZ0pNVzZSNUdldlV6OW5JWDlSU0krL3FGcWZHRFVk?=
 =?utf-8?B?T3IyK0V5bzZkZ2FGOHlHdHJNc2ttcUh0YWdsNjYzRVBNL1J1Qkc0WTVGNk40?=
 =?utf-8?B?RjlmTHR1aWVMa3NKUjlzdnhwcFpuSy96VFhqeTlRakFDZEQ5UGd1K3J4b3Ro?=
 =?utf-8?B?UVpyVzVqMWFrUDAwYm44T0oxRTVYZThoSVpjc2hYa0xuOXNzV1VOOHVSWEpI?=
 =?utf-8?B?NHdWTEpVNU1XczJiRXJRQTQ4MXh1aUNrT3lrMWtGaWoraEhpYU52K1F4Qy9O?=
 =?utf-8?B?SkdlaHRLTTYzQjZDODFXM2MzTGwxS2RXRTBQNmJSU2JBcVR3MUdSckI5Mm5J?=
 =?utf-8?B?UXRqdXVwcVVubVRRWHVVL2doY1JOMjZGWVo1Q0kra2U1UmF4UXZma21rbDl6?=
 =?utf-8?B?MjYxaUkzT0hEY2xHZ3BhOVJYYy90aFZFeUM5Zk1FYzJqTUYyOTY3ckpvUTJm?=
 =?utf-8?B?cXowWGZ2Wi9yVWZMSVZvWUhsWlFwbU13MDUramwrci94Z25uK3BxZnFlYkdi?=
 =?utf-8?B?Z2pyMlc2VkUyYi9yZmJWZ2szV0V6aWl1M2hxTGxUYnZoUHcrWlJBbTl5Qjl3?=
 =?utf-8?B?SmdXbG0yaHBVTzVsc21KU3Fva044NTluSjYzQnlVVXAzNk5UOWFHV254OC95?=
 =?utf-8?B?alFRNmpGWEk5YjNLenV0d0pSczhPZ2NFU3FJMTA2VGhvZlJUQlBhUmRPMURp?=
 =?utf-8?B?K2lMeVdwdkFjeFhsYmRrN1RaZGFERXdMcWdReXF4cnZvN2RMTWNMZVlMNTFw?=
 =?utf-8?B?OGExY1piSTA4WlVybDhsamlJRWs5bVF5V3V3eWtvbVl0ZXNLMXpNczJEcXFq?=
 =?utf-8?B?a3FkL2NIZzNUZ0RvVnF5NFNlYVZZZ0dleDBiNmE2LzNiR3BvTEgrTU1hZTc1?=
 =?utf-8?B?eCs5TmE2NisvUVRIRkJLK3BmK2N3c1NrSzNXVjhoMVF2S29sdkdJckVYTzEy?=
 =?utf-8?B?b1RQSm1wNS9ybThnSXMrSGJBYTZEdFM3c3BEc1hkMXhua3RhVzJTcmExZTIx?=
 =?utf-8?B?NWlzVlBPNFNkei9HZWd6V2JiZW8vV29KdFFXZmlBLzBIM1dHZnkwZkhxN1ZP?=
 =?utf-8?B?Q0UxSFRVU2NmQ2orQXFwYWJzaXVFQ0ZBd08zY1pvSFJRSk5RUWljYWlzOG5X?=
 =?utf-8?Q?Jv0Pyc6+CtiNf+6?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6ec53-0201-46b2-5ee8-08dbb5d8fac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 10:46:12.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1L2I4BxqeABWpnEjY+5U11UQVyiQYgcmdYLLs9dF15NdpXa0p1ZaOjrkbwr9Hmlnye8v9+gReLOr8KZBj7TFbDtfkbuy4GgznQqk74R/Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMDkuMjMgMTI6MzQsIFF1IFdlbnJ1byB3cm90ZToNCj4+IFtzbmlwXQ0KPj4NCj4+ICAg
ICAgICAgICAgaXRlbSAwIGtleSAoWFhYWFhYIFJBSURfU1RSSVBFX0tFWSAzMjc2OCkgaXRlbW9m
ZiBYWFhYWCBpdGVtc2l6ZSAzMg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5jb2Rp
bmc6IFJBSUQwDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJpcGUgMCBkZXZpZCAx
IHBoeXNpY2FsIFhYWFhYWFhYWCBsZW5ndGggMzI3NjgNCj4+ICAgICAgICAgICAgaXRlbSAxIGtl
eSAoWFhYWFhYIFJBSURfU1RSSVBFX0tFWSAxMzEwNzIpIGl0ZW1vZmYgWFhYWFgNCj4+IGl0ZW1z
aXplIDgwDQo+IE1heWJlIHlvdSB3YW50IHRvIHB1dCB0aGUgd2hvbGUgUkFJRF9TVFJJUEVfS0VZ
IGRlZmluaXRpb24gaW50byB0aGUgaGVhZGVycy4NCj4gDQo+IEluIGZhY3QgbXkgaW5pdGlhbCBh
c3N1bXB0aW9uIG9mIHN1Y2ggY2FzZSB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiAN
Cj4gICAgICAgICAgICAgIGl0ZW0gMCBrZXkgKFgrMCBSQUlEX1NUUklQRSAzMkspDQo+IAkJc3Ry
aXBlIDAgZGV2aWQgMSBwaHlzaWNhbCBYWFhYWCBsZW4gMzJLDQo+IAkgICBpdGVtIDEga2V5IChY
KzMySyBSQUlEX1NUUklQRSAzMkspDQo+IAkJc3RyaXBlIDAgZGV2aWQgMSBwaHlzaWNhbCBYWFhY
WCArIDMySyBsZW4gMzJLDQo+IAkgICBpdGVtIDIga2V5IChYKzY0SyBSQUlEX1NUUklQRSA2NEsp
DQo+IAkJc3RyaXBlIDAgZGV2aWQgMiBwaHlzaWNhbCBZWVlZWSBsZW4gNjRLDQo+IAkgICBpdGVt
IDMga2V5IChYKzEyOEsgUkFJRF9TVFJJUEUgMzJLKQ0KPiAJCXN0cmlwZSAwIGRldmlkIDEgcGh5
c2ljYWwgWFhYWFggKyA2NEsgbGVuIDMySw0KPiAgICAgICAgICAgICAgLi4uDQo+IA0KPiBBS0Es
IGVhY2ggUkFJRF9TVFJJUEVfS0VZIHdvdWxkIG9ubHkgY29udGFpbiBhIGNvbnRpbm91cyBwaHlz
aWNhbCBzdHJpcGUuDQo+IEFuZCBpbiBhYm92ZSBjYXNlLCBpdGVtIDAgYW5kIGl0ZW0gMSBjYW4g
YmUgZWFzaWx5IG1lcmdlZCwgYWxzbyBsZW5ndGgNCj4gY2FuIGJlIHJlbW92ZWQuDQo+IA0KPiBB
bmQgdGhpcyBleHBsYWlucyB3aHkgdGhlIGxvb2t1cCBjb2RlIGlzIG1vcmUgY29tcGxleCB0aGFu
IEkgaW5pdGlhbGx5DQo+IHRob3VnaHQuDQo+IA0KPiBCVFcsIHdvdWxkIHRoZSBhYm92ZSBsYXlv
dXQgbWFrZSB0aGUgY29kZSBhIGxpdHRsZSBlYXNpZXI/DQo+IE9yIGlzIHRoZXJlIGFueSBzcGVj
aWFsIHJlYXNvbiBmb3IgdGhlIGV4aXN0aW5nIG9uZSBsYXlvdXQ/DQoNCkl0IHdvdWxkIGRlZmlu
aXRlbHkgbWFrZSB0aGUgY29kZSBlYXNpZXIgdG8gdGhlIGNvc3Qgb2YgbW9yZSBpdGVtcy4gQnV0
IA0Kb2YgY2F1c2Ugc21hbGxlciBpdGVtcywgYXMgd2UgY2FuIGdldCByaWQgb2YgdGhlIHN0cmlk
ZSBsZW5ndGguDQoNCkxldCBtZSB0aGluayBhYm91dCBpdC4NCg==
