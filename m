Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAC605749
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJTGXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJTGXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:23:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86982339F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666247010; x=1697783010;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rspm7FD8VtFPBd8FbS5yOeUzyNRxZlEt6Grw7x718e1XH5VP63LxY3S/
   IYAvTrDCBxvga40lvA+DN64Bmy+3XOAIlCyjf7XVen3heUK53ItxRgE5Y
   y6+sy+xnNEgdwARIjJKdLAqtLowrBTZ7297zbqzFe60wSyemkjrr91Yc0
   6fQr6jufKlkCvGSFZbIPyQjQzknDXVIHQDOPhYeKyfGp8egEwugUdx/+C
   B/Xxr8EatYLs9Etno1OuQ6/t7dH7ieIHn0MA1gBLjBITQqF6IoYe58IcZ
   cV9Me1yuvehv+LKemhf95n5s3gwpRTXCRg40i/j19ANewh1wi/6o3fHAL
   A==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="214678084"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 14:23:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsU7gSunyGcAuHpIh6jw6kYYYnGNuKsghgDIi7Msb3ktQMqIWaRxBGoWyWFfhr1nuUqV+snLDcSGYdAnz7F6HpkF0nAmedEM1VaPY2ZIamY64iE9FozieYL8KsbiMFRC8kpDqM1lzOeAuQAsDqHcDN00+V3FsPY0mjAzNy4Z1iUffLIQguQYzpejdlpsH0J11ULBHIdUBCsV7K5hSVW1HE0YnZ3si3GY6f22AlTvgyBcZMMKEvNb0pHljKXNcdxWg4PNHNEJo3ImB24L6P4B2jtGHee+8X91s2y0UpmtowQCsL38RkDRNMAnVKG6nqmfmENLw5nXDQnuWSRprPEuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eVatfOqpv3y879Sj3CuTWTYQBu5ggTl/ogrFoDg7JZEbsu3LrvAb9bDnpA+21X6qjcMmYH/607GttTKJy5ewKc0wBAjJxe6lLH7+3a70LtoiWNq9VkJ/v7lxV8IFtj7OWzN3q/frfue6DdHOLXuIqA0D6Z7e9LFPEXfKd79uDgKuYpuxoL3i2Oqet4w8OuaC41cA4WqNZDnki8Z1ufJsLxIydlHEEs9K0Ogku4prUqfSLqxYQbBnw4EMt0ELywxpUS99YcsZZss7CMEgUlicjUqY+e96c2rqapCNpvVOoWqNBPHAq29W3tZ4qoHD+v2/caJaIQUTeqAqDwzaMuu/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Bvc3ytkKAgykDlZKM8f3mDPUtBO2irZ9tUmx+iAiAVP0Jd2OOU8Zhy2eSCp0TLZ+X6SsNsaf5GWv36GLC/uG6lpfX2umepQMEf/jlnx4gF9saAkAMcOUhsIaEqOYmtQENIkcxiQyNrzqW7fF+dPWuAt6BmmorfuiXTdwb+cZ0DA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7358.namprd04.prod.outlook.com (2603:10b6:a03:291::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 20 Oct
 2022 06:23:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 06:23:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 15/15] btrfs: remove temporary btrfs_map_token
 declaration in ctree.h
Thread-Topic: [PATCH v3 15/15] btrfs: remove temporary btrfs_map_token
 declaration in ctree.h
Thread-Index: AQHY48tNrxjJZC6U/EO4veSYW00gha4W0VeA
Date:   Thu, 20 Oct 2022 06:23:27 +0000
Message-ID: <d2cf19db-09cc-7367-c3fb-ee249cde6b0c@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <5cfd74155b651c5a4305511e59c3aa1f20090293.1666190850.git.josef@toxicpanda.com>
In-Reply-To: <5cfd74155b651c5a4305511e59c3aa1f20090293.1666190850.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7358:EE_
x-ms-office365-filtering-correlation-id: 6a03a46a-f6e8-4443-c309-08dab26399f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXo/NkHU3N+Oy1FVmKd2tde26gY08Y+1JwQx/y2/AcY0WQWOsN/NUTDE9+b8fw2Ro78iSc1Wq/HxDsg+rWPuXmsG3qhLdjtloF6cvSO2A7rDzgkRQUp2dIWwsAHbF444VC/kwYSFwBEkStQTlO+t+2FVO14eSEz9CeHO7SSfnvAFZx5sPugzHDFd8cGh/NOU5KBBWK9AjcjyvEkHRTmm3jv3WGx+EDijh7UwZzstRk+N6f0gcDO3V1tAKlaBRHaxSwByMV/ii/WZ7CFjWAC6p0+9RdJyfrHKLVWIluOQnbCykWMC66afu/7odM/slBfbsR0JIgoiI+u4R6LDhE7TGEhqzJpKjNoPkcj6723q/Dbud4Li8lEKYgZTVh2/uCF0lPYa14sa5o78e9AL1a88eM1PBZbnFNmtcgB+AcNBRTXTxagYsaJVr4bgKUruiea3/OLHmdkRBoTZ4b2GS7ydxd2EIamAk0TFks/6iR6v6djvvDuooYcE7HZwg7dkR8RAgFTwTqB9bl/5sruSepzRF5uSvzTFn1iaFnw28Sqegk1mH4XKUs3iOFnGFOm059UGNhk3q9tCYVjamlZGJ8zPbTdV8WpQrgxPTJUSnEaXimNV4/Cgw2dZvNEB38MAjw+2bTTJsUNT9MS/bKBUPnweEDx5ckAa/3BvwfFip5Ov7exPfLBGNRscljjjnrp5d17tP+PqW9DQ0Mse2Rvz7zLE34Da34+TkgtJ6l0JMRrkTI6ELuOEYs+Rr5Z4gFfP07IEKRlaR2NBYp6PM7JjuPWGJVTCWf5hOz+nar6frX6NSehZAbmvo4Sgy8N5DIfxAPyfHv4ScNOAwiELya75+pkwxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(31686004)(2616005)(186003)(558084003)(19618925003)(122000001)(2906002)(71200400001)(38070700005)(31696002)(86362001)(36756003)(82960400001)(38100700002)(6506007)(4270600006)(6512007)(66556008)(5660300002)(66476007)(91956017)(66446008)(64756008)(8676002)(41300700001)(6486002)(66946007)(110136005)(8936002)(316002)(478600001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmMvTXdvRFBsYm54ODFsb3UweFBsZGxkcHRTV2JZU1M4QlBncm9oQjhKT2x0?=
 =?utf-8?B?aU5XZEY5YnVaRnF2bTFxSEw5Q1dxZFdoSFVwQmp1OUNPbjl6R1h0WFhaZEhh?=
 =?utf-8?B?Smk4UjMzenB0OGV6bERwZlFyR1RvYXlRTDNrY2hlL3N0YUk2b1o0cmRsb2Fm?=
 =?utf-8?B?RjY1WlRsbUtSTUloRTYxKzJVb09iZVE0ZUxIZDNsQWQ3Z3JHUVo4eVl2b1J0?=
 =?utf-8?B?a2Z0Qkh2Sit5M3dNVkRqMHlkRXhCZ0dVNWtIamovNERJQkZ4dzkxbVdaSVJo?=
 =?utf-8?B?SzkvUEVDcUdHaFNRQmpTWmZXRGJaNmI3R2FhOGdkSmwwcmtQWC9ZWWlDWWxl?=
 =?utf-8?B?ZzRtc0UyK3loVXlldmNBL2tiSGJVUmtlYVovdjFaYmFvMUdEZXJkeDRjd3Ns?=
 =?utf-8?B?UWkralpDYVlUOHA0NjFmc3VyVmNZS1llQXdPOWtmSWV3alRKYVdOOHkwNG8w?=
 =?utf-8?B?MWtqRGg3MlJhVFpFWmhTM1F5RSswVDBPRURMVUY5SjJUbUxGMUdpdDkrVzl6?=
 =?utf-8?B?Vm5YeTk1SitCN1dUWnQzTkNhNUZOczVGRHI1RFFMdnplSGU0WDFCU0JWN2tQ?=
 =?utf-8?B?d0JMK3Vld0JVMy9EQnBDOEpvdlBESUpZYjEyQTk0ZTBTRGdzbWxTYkxHNVJJ?=
 =?utf-8?B?a1FwYzg3eWxUNEhlcVdhSTBJQmlIcVZmbXFtdk1VUDlyd2JSRHhzVkVuSFhi?=
 =?utf-8?B?Q0tzbEl5T2h0aUVHbUNqcEZjcnhjeS9vdHZHVk85SW5jSkZ2N0h4ZGszeDNJ?=
 =?utf-8?B?YnpqTzRJbUdEMnZZU2x4cWtNU0JsdlZJRFY3RGVlcFpEOW5nVG85MHBhVWc0?=
 =?utf-8?B?emY5aTJtOWJBemVvN1R6WnljRnNQSjViMk04VDNQeDNuU1A5dE1TSHZDYWRv?=
 =?utf-8?B?Wk9xcUpRZ2lMMENOUzdYRGh0N1NmOEFUODJXVFVyNDFjV09FS1RqMGxwTmk0?=
 =?utf-8?B?NDhtWWdBR2tDVXpXRDdBWnUrNzdJYWd5em9zSEpyUnlIaWxvdm9CSWVIcHp6?=
 =?utf-8?B?RVo1OGI4dHk2ckZjcC8wS2pZNEdqb0JWRTQyMml3SXM3RmQrMzBaOXJuMS85?=
 =?utf-8?B?dEx1cGEzYmR5Zk1oS0ZvQzRWN2JrNVZZT3JtVzAwTXlaZEJWMHczbGlRZ09u?=
 =?utf-8?B?OXdMWng2RGxSQmdGcmpmOG5qM00yMVhCT3p6Z1pZQ0M2MitYMnhGTG84enlD?=
 =?utf-8?B?ZDRMWDhYbWR5RnU1Mkp4WWhaZURVdkFjZE9tay9LS08vSkEvRW5talNzdkUv?=
 =?utf-8?B?Ykp1SUNmczNERmx3N3JyVnVzN3NDc0c3cklDQy82Mjg2UXdhaVVMSUxxMFJL?=
 =?utf-8?B?MUpib2d6ZjZpMytVVWxQM3ZOUE9wa1ljVU1GUnJLZkFRWHhCbWp0eG1KaDJm?=
 =?utf-8?B?eVA5cG82NEhRVFBBMWtYOTFHSzZNd3Y4bEFnRGhMcWFPM1VCS01RM20wbEk1?=
 =?utf-8?B?YVh1MklxQjREZENVRUtkZWRQWEdmR3BUeno0VTZaNWdOd3VQWHpCd3hPMVgy?=
 =?utf-8?B?VEVzS2o2SS9DUGVoK1BaNkVBUFdURlBOYVZoYSt4Nm56Y2ZUU3JGS1hXeGc0?=
 =?utf-8?B?aFl4WTEwb3didkJiU0NRMWVmczdRU0VnOWJSQm5kWVoyMmtCb2QzZDh2Z2t4?=
 =?utf-8?B?eFpDZTFRU2k3WFJ2aXhjQ2V2V1ZiOC9PSmhFRTRqV015eE1HM3l0ZWVQMHBW?=
 =?utf-8?B?TmxqeHZoU1ByYjBmY3ErYVFvT2ZZUUNtMmNUMzF0bVIySXdsRlhYQWF6T1dp?=
 =?utf-8?B?N09heW5yVmdKQm9aVHZnbkQrUDVPUXhqMkQydUl2WForekxwT2RQSld3bVZW?=
 =?utf-8?B?cnNIWFhRbmpaT08rQ2RId24rTm9xbnU3UUZNQmxpSWlBYysxbS92M2dNWVEv?=
 =?utf-8?B?YkRyMWxPOHlpbHFFMzdHc3E1QTFzYVEzM05pbUdhMWpQNWVGN1N6RElJSkNW?=
 =?utf-8?B?TllRMzFaRG9Rc09rbVlUMDRIN2RybmcxUHdzQnIxRkliT0ZJTExKM2hvUlpw?=
 =?utf-8?B?S3AvbmFUUEgydHc5QXkxSWxjQTFCZk1GaDMyV3NWNTJEd3ZzSnQxMWJYVS9B?=
 =?utf-8?B?ZTR1YlNTOGJMUmtULzdlSE53THVYbkk2UWwvOEd2NFJaUy85T3ZYcldoelI0?=
 =?utf-8?B?eE1FSVJJSWlaMWRHc0ZPWUUxS2VScnRlNUo3WHhpOEx3MjJsUmpka1AvTUtt?=
 =?utf-8?B?dmpiSTZDTi9aaGdyY3JBK09BMHJSSU1TbFl1bDBnS3lSdnlJVWxpMUZuWHFK?=
 =?utf-8?Q?ykn3NjgtxXlLXeXy2Ocyou0v1/ogMY7S5sVaWfgTrM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3B5E13DB9F6F44953E07B990B3C590@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a03a46a-f6e8-4443-c309-08dab26399f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:23:28.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdYdi7n3lsaiTm+/3mhn0yO5Hzs2naG5hMXoAbvjxhvYCPwTdU2FkGBUi61tOdO6mCzHZ7vAlAJP8XZ9d1el9bKA8oRnnXFbXZI8AuZlR48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7358
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
