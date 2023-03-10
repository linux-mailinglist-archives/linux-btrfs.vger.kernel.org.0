Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C356B3902
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCJIlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjCJIkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:40:51 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067BE9CF7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678437536; x=1709973536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XQVCk1qi1ry9g3PAM4tNqDl/R4keQJ8/FnkUQh9ozdc=;
  b=qJ9XIm2200Z4mHMr2RdUcQsa369tgJ9Tm1Qfq3x71ZyMcSR4mVTOohMg
   htmwtYCk+ARanQjCWqmDxncY7TYyykvkJXl7DpUTmGWPVaSvT2763h22y
   Cx1yoYuUrl8EX4qQegdLljPENXFEljF/0K34hbKo08QtKC2epRUW+J935
   PdmdTQXYg80txBuDjJb+WYJ3bpQMWU6iSqZ1iNn8DZPLfmLXLSMvlFa12
   Nj5TdOHDXP2FTcuXAbnqNGPyhV64fxRv4/ASpF3D2EEajLkvGh7oS/75f
   9L/ZrsnZfK7AjckUas+APbN9ElEjFzozeV+H5Y/tF4le+ibzQA7Scd3jr
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673884800"; 
   d="scan'208";a="225088918"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 16:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz6C81NIsEw5LOZXMXGwN68af4OZn7nufLOiTX1pUjFJouQWbbZXvIuNZuut940zZC6toqc7gDxC+jUQQ/Fqg5qMKmFWtIO/ulZTdCPYc4mlXB0rrJYaw+PEnh+crGxpHzjxF+dvxII1iRZLbYHbQOtvuzR53VYqybwKyqtzpM24x+ZRY3vx3I0SvKXwTPPPNFx1NyAsYlKK7AfxOSarG6DG8CuAB7+Kf9MVswdTAEQS2TkZMGj4Rl1VklHMkWiy3u088R3b5XrqDxaooBDI1oF0fcSMynRgmy/4c4gbx7a65m/fJtKlJx870oOnivtb2op0/wg27O1TDKbN1T6MGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQVCk1qi1ry9g3PAM4tNqDl/R4keQJ8/FnkUQh9ozdc=;
 b=Jsl5M5J8n+zLWM22lW1dev6jjtvl0AJN59k/pSzSE9r6sBENvt4b+o9W2Z2TUbe8lDVjRCJTswGXw9WOlCw8mrvYapSUeH2eu7ZawYQ9jlUAWTLXdhzGIiuhu35C/F0BXxUDzOKw7ObjEEEEAotUjG7kZ2lD+mjgqdr6t2D7Sniwaqo3+asFXdRZMYgaY5XIKlsrMHuRBqN8VAFwuRV3Dhx/E7tHXYZA5N6FVeU8Dl1uUsW1PiD/vrv98uLkvf7a+5jFVQsJvlciiK1XLTFXBMHT/H/+3/ikwAIcRqbrmmtpUHeoVjNbCEsVDmcJ+HzT87juXYYooQ5W92KaDPYIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQVCk1qi1ry9g3PAM4tNqDl/R4keQJ8/FnkUQh9ozdc=;
 b=Jct2JC6687rtuVw1k+WzR9lB7PxsD71iy/Ji2DL+jvMh1njE5z9XKEOlSaNuI19R3YOcyH2qLTwmjIfXiWi/stZwWlMcnl+Yvxe5e4s2T01XGwgFlak+2bW6DpoUrclgYgK2OJc1dS6tf3GZyjRm+uurgtEFqJkndr2T4s5kehM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6226.namprd04.prod.outlook.com (2603:10b6:408:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 08:38:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 08:38:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Thread-Topic: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Thread-Index: AQHZQUosDMpl+3pj50aDHiPnO2nBa67y6kOAgADqo4A=
Date:   Fri, 10 Mar 2023 08:38:52 +0000
Message-ID: <a436c153-3362-1608-d8d2-ac1e7313e45d@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
 <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
 <20230309183903.GM10580@twin.jikos.cz>
In-Reply-To: <20230309183903.GM10580@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6226:EE_
x-ms-office365-filtering-correlation-id: 2640bc1f-b4d2-49a8-6b0a-08db2142e0d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDwmfaPyLExPru0QkEDQ3u6OQMflj9sWy+WM5sXggsk5o0W8ciG0omiU2+QSe9A761w4Z8T0GaewQ48ZdgbedDqaaW1z16Gwqzbcw2Rt8tjYiH2vSjGZx2QLbSoRPH7I3O7qair5UvoAeyrOS4SecYQA9Zy8kCgz+M1zeiu4yrRvQraai9UnVMGL6MhkpzOSN5ZogD782lgJWUawCeOzV1wuRJqVvMzrduyeFfq9fompRob10Z7mlClu9iG6d0NP5cxKYDn8vzZI0/T+5cqRfHiYiMp99bl4A74XqPAxCgqoj81unxqcCEvoXYAYCEe5JtSxyUH0jj2n/sNPpWbB6mbKXA0bH67fXc/lyXbD2jAEEs11Io9QlmeWiilsOQzTlWiUqaRRhCErd1j65yxEZvgOtaAtUiS9ghkkQDiBNRL8gVXvWlYAdzK3oFV1oCPzJiIups8PYQScIzVp1jCHRAghuGpyLvzXl22/aO/4x3Wg3aM17IOddeVLpIfl5qzzvkilT12VMRDBaCFa8BMDokGPpZTH62NaD4RoC1EepNVVpQJLgqN2mGr5PBJBaFVBnDxuoF9ye+u7FmkDLSbD2mc2y6bprtOZk7t5uNRPCJRhpRWLV95XtjcFMQNajIG/aldHBOkKDCqhNGBJbmHYLf1qEAc7pFa2ad2eTaPwchWMxF2D3GZNx174GVPH/OlVmS5Lt2kzs3taBronZwHGvAG/M/7dbrqGSgrse2VTrH2wJC08hTjmyHVYE/kOuP/IFPvYyKqk4dLVwvwHByLvwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(5660300002)(41300700001)(6486002)(186003)(53546011)(6506007)(6512007)(71200400001)(91956017)(64756008)(66476007)(66446008)(4326008)(6916009)(66556008)(66946007)(8676002)(76116006)(478600001)(316002)(36756003)(8936002)(2906002)(38100700002)(122000001)(2616005)(83380400001)(31686004)(31696002)(86362001)(82960400001)(38070700005)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmxlYWRpVXp6VzN5TEo0TzRtRW1kY3NSKzlTcGlJSTl6VllXc2JReFhCd2hF?=
 =?utf-8?B?NURzNEFoL2lWeWxEVFpOOHJ4cDREMFBCck5OYk02Tld4QmoxSHJLb2FwVm9w?=
 =?utf-8?B?WEliMHdUSHp3NE1HemU0TkozQkVvQXp1NG82ZFRUaFRWbEwvTjVCckpOMmlE?=
 =?utf-8?B?NEV3RlBNV2Y0a0ZLcjhSRmhCc3I4QUtXRE9EYkRaUWV4OFdlNzZtT05HcXRz?=
 =?utf-8?B?U0c3VnpLUmhaM0ZRaEVGay9nbW1QL2JjQW9kYUh5Rmx2ZmRVL2l1OWRWUW1u?=
 =?utf-8?B?R09pU3hqdHQxL3pNM29DS1ErTFQvTVQxZkloR2MzRDlUU3NWTXFmSGpPNEdY?=
 =?utf-8?B?bGFDWVNYZHVUUFlWemsxWDR3MEsxWDdzcXYyL3hWbGxNbHBmZEVhLytXRFkx?=
 =?utf-8?B?OWFXbVBJREg5U1luOHY3eTdyUC9vZE5qb0RSMjBSQ3pCZWI3VEp6dENlNmNO?=
 =?utf-8?B?QTd6MUNjWGtldlBjcmVPUjBHY3V0OVR3bFNDRSsrT3ZtaDhYKy9SSDdEZVpC?=
 =?utf-8?B?VnMvSk9TZkwzakQ3dDI5K1FXNXB4S3poSU9qTGJLRVdSNTVLWDFzWEtDek5O?=
 =?utf-8?B?QzlUQVlNRXpYR3o0NWJsRUlDMHRhOStnRVBzRTNzOXg4cFdsSU9CL2M4cXc5?=
 =?utf-8?B?NmNtbDFxbk1lUmxteHVzS0xtbU9YdjRxbFFkWWtNNTgwUGEybys4WDd1Wkl1?=
 =?utf-8?B?UjVKUjQ4ZXJlaXpWcUk5RCtjU2o1RUE2bFB2dlJSV3J6UzgzVWtTZjc3T3c0?=
 =?utf-8?B?Q2FVbDIzbk4xZWpZYms1YXZlU1J6amhFZDgyT0xvanZyQkF1ZmFUZ0FCMzB3?=
 =?utf-8?B?UnBVUmhVOGRNK1o0RitST3lOQVd2RWE1NUNTWGNPcHZhNlptRHFEdzlvbXE0?=
 =?utf-8?B?M1dDMEFRZ3ExcUF6Y0RYbVR3bVlJdWZReXBPbkNJalBCVytBYVlwTkxjZ2sv?=
 =?utf-8?B?akU4V1ZUejNsSUJUWnpOZXlLNTYranVhbUN2WGlWQ1AxcmN4Y1NGMGc1ZTZK?=
 =?utf-8?B?L08xa21hSjk3MHlsRVd0aVBZUUZTVkw2VFVvT2YyaGpEeis3cTNjWDdabFc3?=
 =?utf-8?B?aHc5aWptN2xoM3hKZ1NrdUtrRWNERlM4Ui9mVjRoUUVmYW80ZGoyUGFiQkd6?=
 =?utf-8?B?bng1NmQ4aFpRMXdkU3cyOUVWb1pTdVdkdDZKSTBQV2Z0OURyUjVCa2FrSmtv?=
 =?utf-8?B?NkZGaTg0RlRnOVRlR3Z6NmY3RVR0ZmJvelBneVhVcXRMNmNVZmV0VlhrdTll?=
 =?utf-8?B?eWpWU0tWVE9NRTNpV2o5RTVIQXMrMmZjbmJQckNibWFqS2J1bkhPYUR3RXdy?=
 =?utf-8?B?UFNlM1gyOGFwaGwyTEMvVWV1L0RiUGVrSzBUWHhndkVqRXRpSENxbVVSWGsy?=
 =?utf-8?B?TkFYTkF4WHNRWVd2US9nOHhwUW9HVk5HRXNPK3VneWRLM3hWdjYyL1lSVjVQ?=
 =?utf-8?B?dFB5c0xJZk5ocUxGbHZZT2c5QklpNzhnSjF6ZHA1UXBkV0cyVEFoZ0lZVm44?=
 =?utf-8?B?MXhEVGF5WTBncEt5Mkxia1lSWFptZFRNUnRuNnVWTWpmUkFMdDUxbHg5SE9I?=
 =?utf-8?B?aFlsUVlQejJBbExMOTluM2dHVlhINklDQjlWWTNobUdPTjBpWG4wZkRvMlc3?=
 =?utf-8?B?bzBMNUpkclloMlJwL3BhZzFsR1YxRWd2YkhGT3F1ZDhDU2UvVUpYRlFHV1Vq?=
 =?utf-8?B?YlVsK1RhNVFRMysxZTdxVkxkYktwZVkxL2VDWUZES1NUbDJSUmxnZ0JQcWwv?=
 =?utf-8?B?Q05LMHQ4aElXNnJ0R0VoZGR6WkFTN0kzN21FQnAvcEhoVGJtaVhlMmtycmZW?=
 =?utf-8?B?SVJFQ2xOZTkwWUhCOVJ1c3hUamVTcUQ2V0pWaVJiS04vd01YR3VTR3prNmxN?=
 =?utf-8?B?NndnT0FwZVVNaFk4bFN2MVRvY2NXS0E1QkI3bzh4ay9oVDg4R24ycXljeEtU?=
 =?utf-8?B?dkRWL3hadVFmRXJjOWxXWm1VaWZ5RVkrcWk2WFUxdGVPWC9CNHVKQzVVaFdV?=
 =?utf-8?B?NzY4MWlLSFhMdEIvcWFlV3N0VGI3Uy9KaytyV2R1UnFXUWpEQjBDTDZrcHcv?=
 =?utf-8?B?WVlja090YWZUeGdTZ1JWZm0xZHNuOUxCaWVMZy92SVdBTGVOZWNVQ3Z2Z2kv?=
 =?utf-8?B?Y1dJL3dpL3VBbWhzcDZKYnVpTDg4ZUFuRWRsSGtLNlo2Q0ZzeDEraDBiUjJ1?=
 =?utf-8?B?Q2x4VFRDUklUNHZSNGhJemo1WjRZZWNEdnpiZWExSDNPTy8xQWdzdFlTblhL?=
 =?utf-8?Q?gNeR1A5BEECV4ooZudrGeYszMeB2Mb/NWYOh2D3wMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9CA8CCB409E843BD3CCA2B2BCB3984@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UBWs2qkVlyjGo9X/vxDLLO9SvUw1EkdaXEemB+6BKNbrckhurgW3nmNu3h5tum6X3xoOIO2aitGwGj7eH3mDIGXTU7K/Pi0f668bXNtVN30AsGOIqjhMzI+5orxpkg2K3JYT6v0b8lJJmblBDT8gdxHdjnHGRkuhLuveewMmcZONknviORQZ2z4GxeH8x7CuGe5iQAZznlVYa2eAfnVzNmlJWurtjRqrKUt+ql/CWu+9/ZQwTEWWTwTLMz5fdG4aLLm06XepPyYyf7hprDXlGyM3p8I38Kumte31Bz77da8IFWjnSycuuKoy8GnlkkIQaV3WRBa+6KgAUG/A5KV6wW9DcXNLtz45nthjVwIPavt/ygtFu9l83FiFnpjZcwz4mcZfayIZ7428Mr1nBbeD8fbFbrz0DFs9bIBAUZIen6j9RSbAxSYVIfcWmqGfxtt+es5XVfDwhl7Ne1aGkuWeurGNK3BhqPSjDLX5npW7bPc1SvpyaKiE8X+mTVNNFfurGlY8a3FPgDskBxhHXBxRweihZtbnK/dMLmlumAAPa9ZoG+iDuwIAvHMVyxK75IUb9mMXbx5p/vPEp7gE5Zqn6WqBq53k9Oj5uoPU2dxWAx7Q8Rq+uMQnFMyIK7G0/4KLs60DhoFj0QEu/LgzNGfq4sxi5mgQKIfsWqqp44yYeAfv7RXmWHGH65swwztlmHssZnl3gtuVNIKAnoLr0K6QuiC3sUDAsv6ddaszB+AWU3C4I04Yqw5q0YzNxSi0oJoYR3zgvGgrkmX4eTCQu21tTRLQ9NjQzAeYza8LESMaxEg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2640bc1f-b4d2-49a8-6b0a-08db2142e0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 08:38:52.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6ijrmlc6DGYvcp+g2gfXrw/PACXN6M2Z2+oyhSuSnUAPYlezHzpLW4r1+tJihQAW+CzLkt8j5rhztDFa3j+XMriwyqqyLLb2hSQ4MFY058=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6226
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTk6NDUsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gSSd2ZSBub3RpY2VkIHRo
YXQgdGhvdWdoIGl0J3Mgbm90IGNoYW5nZWQgaW4gdGhpcyBwYXRjaCwgc3VjaCB1c2Ugb2YgdGhl
DQo+IG1hY3JvIGlzIHdyb25nIGFzIEVYUEVSSU1FTlRBTCBpcyBhbHdheXMgZGVmaW5lZCBhbmQg
bXVzdCBiZSBjaGVja2VkIGZvcg0KPiAwIG9yIDEuDQoNCkFoIGRhbW4sIG9rIHdpbGwgZG8gDQo=
