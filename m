Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269846A81FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCBMSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 07:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBMSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 07:18:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0081ABC8
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 04:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677759486; x=1709295486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=o6rEq5KL4IaiVrEr3aSf3zd3uj1R15x5zTGu0jwi8FJTqVTp3LrtXVKo
   MI2MbdCaHHuwDVpeoMQobbjZ9XXGKeTlVvrN0e5zZeWUvKlL7LZ9chdm+
   0dGEIb4cziOLA3v7F/jaLCAIzz5ezKRVK9WLnKRGpYRzCV6y8pKYN4Fdz
   UGmJIlR3P/jizXsJJNVb8jAS1LFVmi6GLyD1mnfMty2mb4vbBXi9v8H6D
   ujTSwaM7RSQ9HYs6Zs//6FO2R9Ie3bYIvBySUZ4MafHs4pfvw+mZfLcI4
   WnWN7cmMewF1IfDtNepXHwmxSj2DB0RSpuhrr2i6pB6dyUvtnJsZARTnz
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="336604975"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 20:18:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpfULvHWJrVbOyySogOgGZ18Eur2xDzh4ZDxbFTi87qdEjJqA5vjRtNH/xGFCWnKJwypFSJd4NG/hAEIYZgwVv013mn3D13wH5M9WA88sBg440ML5rxtiG3xPRLDfICxra5IJgup0J1GekcfsQRXyC/MKFzWGH3miAjSx4jXRbl1XA44Dh+dFoiNVNsev6y1JUeDgAvppCACCLjFv3GvQKmBOmScXJfhAUD2qq5EGXtDVMu2K1+RwpLjT6BoOei8wCASbzZDQyb7SGma20a6aZbV3hA8SgZ24dNKXE7w3Xc25mUT5oNBZHzz8OqG8nDtpNTwHo30vzFqWgv+ls8owQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=V4bXctb20iO3NqICSsMxt/AcuxgLGqBk7otT+He10BsjWMQmC/0Jbj7LQG9564xGfT7qjJNMEh4m0FGI4Cfb6YKbms4Xge9V6caxTEHYwe/V7cbuZ9oCH58rqWcDR2jtoarVHuvWgjWxzElj3I1fd2Sv+pM9baCfTXZxfjf8hbEm+eU0TLoQM0425xPPl020IOeo1QkCXiocXUMFyftYxiezzTgcOtnoidLdRDhqmbhRN6N/vLGPlfFeA+OycBmgLAY/5NBKjdjZQowBuUG/hlHlDdw2ISMqN5RDyT3AC8rgu7SGspxspYs00znexRuTWa2Oeaa374BNKjTay+czgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=poxQ3TqiGKFaGxJe779c+tMdZTDN5l6OaCzkeuS7zNNV+FfXdb6Q6SThlHYhyrmCsaiuYFyzBzy5kVJ4KtZ/9BBjNA4zQVPFTC2I6iPLEm8z7mlDN304feQGYzjiulreOS+nbVGG/Er3Mk6jgurUEBVwoUfRgPcrWlYLUvhSfMg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4823.namprd04.prod.outlook.com (2603:10b6:a03:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Thu, 2 Mar
 2023 12:18:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 12:18:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/10] btrfs: move zero filling of compressed read bios
 into common code
Thread-Topic: [PATCH 03/10] btrfs: move zero filling of compressed read bios
 into common code
Thread-Index: AQHZTEPGAJC4wUu8dUSEStB7cqvYja7naYaA
Date:   Thu, 2 Mar 2023 12:17:59 +0000
Message-ID: <ad377555-65a1-485b-b0a7-9ae0665210b2@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-4-hch@lst.de>
In-Reply-To: <20230301134244.1378533-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4823:EE_
x-ms-office365-filtering-correlation-id: b71988a7-279f-4324-a5d7-08db1b1829d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKwjxSn47l84rCmgoAShvHocSE05a9BYvJJ3KJa66IqXcqMBZbqXI1IfkMzhS4yFlqrIMhZLFNTdtNe7fPY6FDf4LDXn+bctkbrwczJCxrp3JYfEhjLHDzsL+BkNX5w9n4Vt0AcCVme2RU5uN6WhObIy5MX6c4xqCFSElwgvFg26iYt8UlgVFPHWfLOEDA0Nh1FIMKfUEvtrfh1OtU0JNFUTJyVF9xxht0ac8FIfSUeQOC9Z62XajAZ/4tyF8USR+PKAEglwVS4MeXB8lGlWAfvIuZe7A3yHYI+7gZW5m9Xh79V1x+KYx3iv55pn9LCzK/xMcKt8oRUBFmHPvNVrs2TnvPNT81pByKMVYYKJHEk6y+0/DQLKMlhxAJXt1dWhDbD+rbB8XIBmR4+y5Mi59hfocMruR8lDcSBpqaUZRDSLbk1be493QEEkYgXF/Pmo2EnokMrBPkpHuf3ydJCMwsZrqvf0+OQRRgZAPXuHnNeZpaUbDBR1MQyHJSPnqUD9hW69NOTQdcK7jRRbZ83FX9WPsfQbhyZBxBMfWVqQOc/Ewk8v8lhcaFzYDm8cvt+uJ0jhrGgz4bjF/9cCtD/T65FBVM9UbHvzJFRbhYAP1si4oWtopE8fnKWXmyYsMZrlOaZ05bN152aoSQh13MnzJeMqW5CqCE26bo5SDHS5mWcnxcYs9k38UQ8mZDMMlZ/q2QH+JQ49jAb79FmGio6Nr1eazydMEHxyDFcqIO6VWP+yXxiqG7X2P1OAR2RkCadtJo+Pe15bAREcjouTe0tM0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(558084003)(186003)(31696002)(6512007)(4270600006)(6486002)(82960400001)(41300700001)(38070700005)(478600001)(36756003)(122000001)(6506007)(5660300002)(38100700002)(71200400001)(8936002)(76116006)(316002)(66556008)(66446008)(64756008)(31686004)(110136005)(66476007)(91956017)(66946007)(19618925003)(8676002)(86362001)(2616005)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0Z1NHRnSmZjVTJGbmE2SUZiYjZnUWMrcVBaTnkwZDJTK1JHOGdOQ25DMENn?=
 =?utf-8?B?Z2ozMW9PRStxcG4wMmh6QlFUeUp1eUFidkp4OVkxUUFyYVF1RjlMSHF2c1Bt?=
 =?utf-8?B?NVNWdmZlbWpTYUZoWlNMeDhQdW1JZG5FbE9pQjIvYy9mbWs1cS9RMWlrWWJl?=
 =?utf-8?B?R1cyUU1zd0w2UTIzeHFBdzVIM2JsbGIwU3Z5TEZxWWFGdjdDMWo1RkloUWFD?=
 =?utf-8?B?SU5wK296U1R0Y2ErdVAvN1FFTXBzeVVQa0tQanFrVXo2eWJwcWxlZG9sTWwy?=
 =?utf-8?B?RnBEdEJnVmhIMkNwcmZjYVZwalcxcW9KZWkyL0ZVZUsxbUdnN2h3ZUhESjkx?=
 =?utf-8?B?ZG52OEpNdk9HOGJ6bmZBSDhrZytLNDAwRU1RamhJcE9NY2R1RDdFbTRqeHI1?=
 =?utf-8?B?ekIwY1VDazN4WHp0U1hOdzRRelZFdW16WXFpT2hBL2Zna1VyaDl4QVFieVZB?=
 =?utf-8?B?dFZpSGtoQlYwS3k4UktOZUVzWXdEMDlkamdYbm5WSFNpOSt6NnpGRlUyWmJY?=
 =?utf-8?B?VVRvNmV1aWhTandEU05rZlFTdW85NVR2NFdKUUxXUVVhWmc3M1ZOK21pajVa?=
 =?utf-8?B?eG5mWEwyMHNXOERZRUkvd1AvNTZnd0w1MjFBWnFqYnJWcy8zOC85Vkw4NWFo?=
 =?utf-8?B?eVMwa2RkL1FIaFJOQWN5dGhaTXYveDhKaUpuTVZNWktqeXRPejhpNDUxQzBQ?=
 =?utf-8?B?YnNMTDNremUweGY0WXhJZUlXSHhGelJIMDNlK0RuUXdMUUJuLzFDWmlHWGor?=
 =?utf-8?B?eFRyRktzeEtYdmFaeFEzelphTk1DZUNhVFYvN1hjZGNPeFJhZGVpc1BZenFU?=
 =?utf-8?B?b2FGSTlaT2FNWmJ1N0IrcEJ1MDZORkk3QjJHVklmUHZrNDcxYlVMY2lPczZI?=
 =?utf-8?B?NXcvNm1admJmVzZacmdsb2Z1Yk1GMmhwS2RjRERNRUFrRlJOUnFLWmIvNzFJ?=
 =?utf-8?B?bVZDYm5nVGd5RUFWTEN3S1JpNnBtYjVGQ2E5QTRCK3VPTFNNbEJzQnRzUXAw?=
 =?utf-8?B?azBEaVpZeWhrSDhBT1BHc3N1eVFyWTEwakJMRmdYZWtyK2xWVlEzT1JXMU5P?=
 =?utf-8?B?M2hTZzN1TkcvVThvcVo2dmhkTjYxZGlYaW5KbkN2TklFc2FXZGJPMkk3RW54?=
 =?utf-8?B?TEdPTjlVbE91bytJdHlEYnVEWUp6NmF4VnhZdk9OdEFnQWVlalRSd05RMG5Q?=
 =?utf-8?B?dWNxSVJGS1VJdEw1R3RGVzdRNmloM3UvZkZxMmE2NXJtZmFUdElobVFiK1hC?=
 =?utf-8?B?MFJnQithVGpkL2Z2a1hwQzVTa2hDa2VFazNiVHd0S3hOTm1MdUdoWWd2OHcv?=
 =?utf-8?B?dzVmakwwUUs1SmE0cXdyR2ZtM1JDZXl4WVczL3VRRXdTZjFZLzd2TTJwMjlh?=
 =?utf-8?B?S0M0ZHlIUDZDNGhCVFdWNlE2eHl0OFYvTFd2WVhHYnY2T3lyOWwxV3ZmMHc3?=
 =?utf-8?B?cDFlWGNVZ0hGWXN2ejJIQUdMMmpXbFJFYW5tdVZkS0lHYzM2RlpaSTk3R1dK?=
 =?utf-8?B?bWpwT1BtTmxqay8xZEZ5Mk43N01la3BDQjY1dHk5QU1hYkFiQU5zQldReng2?=
 =?utf-8?B?STBTUUFhOTBGSXc1RUozdVJwNFU2QlBzUmVzZTRwdUtzY0lXTndOdll4WFdL?=
 =?utf-8?B?WHduZGk0b0FXZ0RrK1dDS1ZLd2hIamlhMUIzL0hXZWZ1ZVgzOEF4SzNVTjVW?=
 =?utf-8?B?YmE0SWJnOUpveEhRdXRsTE13VmpiNHU0WGFiTjlYME5pOFpWRWxOaWVCVGto?=
 =?utf-8?B?THVFelkxMUJHbEhJa2RUajQ5STByUmJDNkFYc1ZHbDRmeFNXT1FuVWlVOWtv?=
 =?utf-8?B?dUVDUStFRXgxcnRkeE5RaWlUMGw0MzBFRDZvenJyZ0ozcmhxc2M5bnZNNnNa?=
 =?utf-8?B?emFuK3dIOUFIMjg4cEYydXhrTEE0d01WM0J6SVUyVWdYOGl5Z1BJajFGdUtt?=
 =?utf-8?B?L3NGMnQ4RHhKSnFncmtNb1RvVTJBc3FIcU4rRDZFQ2Z0K0VBYXByemw1TFMy?=
 =?utf-8?B?SDNtZFpSaitmVmdwdkFha3pnZlRrdXJrMGhCeDNDQ1N6d20rMmt1b3lnK2hu?=
 =?utf-8?B?d1cxYm5rUHhXdjlvTVh4V3A4NGwyd2ZjRE8xa0F3aG5YZmdEd3ZPTmtRQVp5?=
 =?utf-8?B?SWFiZUIzSytkUURia2lZSENHLzBsWkNBZXV0VXJOY01KUnNhZU0yV3Y5Y0VH?=
 =?utf-8?B?MDFDRGNyNGFjL3lSaHZqRTVOSktndGlDSVdXSWoxc2ExRDdadzRoYnRkQWZm?=
 =?utf-8?B?b00wZysyVXo0WlFUVVRSYkxmUTZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A0F4DB6EA87349A056D9564E3C2396@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XxW5GucLxxDZmuBeoshFbaIp/xZdMIsfzvFn2iTErff8zhVHYOhXt/+h6QHq6lHSWvYFCpXn7nlGdN79bvHwZ3VKbNPM55XvpjAyE9B/gVC6CNDVTaCNmeDqWHd+VKB3G2oeP59sD3gCbhGssiuLG88MWCgMyneTb4qw3U4fnAvwoD+64bxcYXZL1p4r99YBKDm6g6IFLloV+I3RYMMObn5LKE1N48MbEnaMWHp4OCtXrlK7iuMhoYiiNxDKDW4+Z1IJyEh/azF2nJ7/vUnDTWpccx8pnBPjt8I/3UtUYMz4DbufdXeWoFkWHgTpeUhwsZx7Kv1psY9rnng8UsFwhDMVUaMrnYTzbpuvZGZgTqj+4s+2rhDRlaVmzNEugd12BqrSWXNrEcQ35gEYQZ2m9Kd1+c1pCBXbax27UWPs7CaCYFVY8DU3SiM1UuSTBK9mm7dXi0VHFTsxEVhSp9Jc0U2WPZgfPjl0KnNYRGVvEXo+mrL0OO5O2Xu8otVudoFjhENX9v5LISG4+Qkdk1eCvRIL8vspiauGOgFARmSsdrqefv/4ZczHR9SNRE+sRRhaZ+us3W1HEWOp6WJayjhBD+UPZy0/U4m3YM35VOLU2febA9Tn7vpau1UwQc9c1JE8NMBb3/99hU4TV3MM9oYEyGyYcmWo0V5H7NYHd8pc1BAVvMUKT/hWBtDm4jf1t5x7Qh6fzgHahmqPqKCaIAfEscm2elAEL/Vwb0BDVyNe1CZZEfQqm+9MDsMfGYe/JV8MgoIleYCSgNUjnXJsNWNw5exw1BxAJ5XIsD9SaWeF/u5DQrLM2Slk5SUXwrOsM5Tpyfd/DBAEUGltZvJRPwhbZbb0owatsFu7l4ReAbCGZkkk3q6LvM2Ls4lWAnkslLZv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71988a7-279f-4324-a5d7-08db1b1829d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 12:17:59.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2obYItB5Hxzndpv0yDK+SY8fyfJqFPO97ime7rrj3oUi+e2tE08qChwxE2cEqHKKDeerSa/DuLPCteLsbmbd8y6uzMGq7/CKN8gxw9lPRtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4823
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
