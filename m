Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4A711101
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEYQaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYQaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 12:30:05 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F3189
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685032165; x=1716568165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Fgxv6IeWerDSMwMy8qbuVtH1q6KDKU65jqxeY/5AylZQbK8IbxY1cYjK
   FHcFihLbSczCMMr0ur/aR2koXFCrZ53Tlm4WuY66ll9tVZULM/QPLqwHV
   61buhOTfPrmJqUsByCKgllyibkogXaowe4hW8O7/ON0SdzeY8gaebMgFt
   IWH5g/l6/Fk6NkZtlRuer8hFVhK+pjh/it1gGiqhMlvSj63P2fHjZWEL4
   U0PY1S2lr/7PNkXDPs0BhiGNIWTOEMB8ZLL8pQwl2/ZnXD4oWKSBaMzH9
   KX7qPL6Vi4gnUng+WP+M4HZLL9yqAWzQnV2pCoX7OVXYMjwkXSPF0MCAd
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="343740544"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 00:28:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZp/HOmDYW7z2qZTEOjiptI8xxKcD6YdLEKG1g/ik+jKDWntXtmwnmhkfNg+WugtswjQ7gTNXNWzdLBmfXJzcD+laJlo5FeKQsh05IC3z6DJ3A4hTPEg2T5nT1M6NrvX4eZCxg9Lvh9rh2r3kwpI7XgSmh7tLNuR15cb7HRDlRDBKhyGw7utTvQ+kwIum+86bI7pHOZXdsPy1VU+WLruhKHviU//u9Asaj54Ec7d3YRP4vwwTmo68/90Wr5bKhHnEsjc/mMJ6To+i8Qtd0o/lxXUdSoj59CQSafGpjUMkZNeLNiTeQ8exuSSjS4wH/i2TRVDc5aI1tMvkTa+KwM6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Pk+88aiUjXMTuP+Q97qoknUh+fLmXFGXxcawgC/SPfLFmjqenfmlgZLyYDVNUiFN0yrmc3Ch9/7VGecUUE7VrX98ikHm6rQzVmmXu83gYrp5/8KBNGfMbNOb1gn3CtfCDQmp9BH5LT/vmqWzemW6x7mtAKpJRrwDiQlZ4GbTAYw9ktydXOfUwL2XMZHK5MdJFR/ZHqVxUfR5zLNsNrFfSVu1iiAWpblw9KLjYxi/1JTgZ42dI64LdK7zGWVvVFE6IN7R+wf8RAB8lzLCyB/VV+NwrClcJ0mgjmoElXpSlGdRBg9NugV1zsMt6+X4tMDmURhexeD0DToqel12N1iLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Blv9ipymzM7XFN70uAZCiEQEB5h9jqNwXamZCYro9NwhJijA5WGZI9mbbOQdUmqJnoMxSVMB1gqqlVl/GMrT8rBrh/2Kz32GWNvQcZoqlFvZ++R6KN3nnrS2cGRk84OhFVNY0c+lFF6crKXH5bPwiebtLOwxCqVOpIiBnzMX1Lg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8787.namprd04.prod.outlook.com (2603:10b6:208:493::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 16:28:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 16:28:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/14] btrfs: pass the new logical address to
 split_extent_map
Thread-Topic: [PATCH 14/14] btrfs: pass the new logical address to
 split_extent_map
Thread-Index: AQHZjlD+/mgwmzRqwkGCkJoHKmBSY69rLy4A
Date:   Thu, 25 May 2023 16:28:17 +0000
Message-ID: <c65b5c2b-ba4e-51bb-a732-147d97b85d1c@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-15-hch@lst.de>
In-Reply-To: <20230524150317.1767981-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8787:EE_
x-ms-office365-filtering-correlation-id: 283d8265-c276-4a4d-1672-08db5d3d0b87
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDxSUzIFcEvfCrX+yyJ6DuC+jvE4bAhC0jjfEKxnN32APaSp/27vvlQ1MHRWGD2bOrgvzYxURCS700I+YctEINlQTUqESQMtmE6qDTgSfl3fc7ZXB2r87Ay5cGn2XkoDtz9vPoPmv//4Zn8Ri+NeW7C3ibqyrAU2zpdo9In2KvfVz7utzxJDygB7XVh0bGuh8xE0CSM1glt2VRu9eeVnnFPMXD0DSRK3FDi1/xhYPhaifOylVMFcOL3JRgQGUuUKbMExsJO7KMc3rnd9TSPnwWZpnJE9iTeQLurAXMddu1ZVw0+kMwqYdDw/BBF1jl48M9RN6wjPBnXZGGLrRbunONKvymJR6JIKpsF9DhP7tPirtMq/NAoh8xtemY608geDqZzyJE6q+OfdCvS7xP0k5Kgr2vOzS9kow5B5u59Tyffjrt5KIOPFrnXG8sqqIeFmuiW2v4Y1zvEIZd+vGxfEscUAv8gsf+HjceQ9DzlLGcCw+tUQpie3DTcFnMYMRFWJCHCDxBCCEiDvEPO7CqNEwuOPG1eXCQhAMvPnS48F7YtmblKmiVAQrtJo31FksiOeSvGUdQI2Sb4ihrk9V+oKBeH7IJ258byBVKZfRs74Yqoyt+spC3BnwaWDct2O3RbuV6yGhEtoww8tclkevkT9vrVO6u6VTNlpPCUC65aqAOw8bSjoQCaMukkYIaX308dm3o8DPaUWw50kusn8xy59juG47aNibnVKmzMRXBFDSCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(38070700005)(558084003)(86362001)(31696002)(38100700002)(82960400001)(122000001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(71200400001)(64756008)(66446008)(91956017)(76116006)(66946007)(4326008)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdoeVFHNm9RbHZiT0wxcHM2bER6Nmx1U01iZ2YveTB0RUNqZXhVVVRISjBG?=
 =?utf-8?B?enBuT1gxeTB2Zjh1OGNxYnBnMVp6cUl5ZVdaUy9Fa3RUbmVSQy92YzY0Njlo?=
 =?utf-8?B?UmpkckpvN2FrWXFpQmJMNzVGR21BQWVMY3R0QklmSUpFdDFGSFNncVRZUnpU?=
 =?utf-8?B?d3NEazcyWGd4OHVCNmJnTkZJdWFWZlhSWXNSVkpDT2VDMWVUaTZXOTlUQktX?=
 =?utf-8?B?Q2c5ckd5K3FFclhHNlVNTzlGZGI3WmFIR2NxZVdubWF0WGpVdElsemZBMFVo?=
 =?utf-8?B?czZSUzRLVTVJQUNwUWtMTFRjSnU3Y3dmUkhWQURvS2ZXdXU1ZEVWeXN6eGtm?=
 =?utf-8?B?dC9DQ0VTOTZrR2F6OWx3UTFwaEhheTRIN25oZ1FLZ09valZ5eG5UcmdyMjkz?=
 =?utf-8?B?d2lkOTE4c0FFZmswNmVEV1NiVDd5OFYzVWg4QktKR3gvMUJOQ0s2anBESC9a?=
 =?utf-8?B?emprVktjbER0MDRSQ2ttTGN4T1JpSzlyalc2aXk2MEpzV1FGOFBJTG9OT0gx?=
 =?utf-8?B?TUQzK3VwcEsvMU9NQkpyL0lIMkw3cTkxNDdycWtyZG9TZG5NcFZ2NEsybmMx?=
 =?utf-8?B?N1RKK2hMMXUva09QY1UrVnRPUnJxZUx1N1NwL1UrNW9oMExYUStkdGpGK2xy?=
 =?utf-8?B?SDdKa01GZlNjalFyS091SnNMSjhmdmlaYktEZEI3Ymw2U2FIa1lzL1RtQUZX?=
 =?utf-8?B?UHRvY0JWaUdldlNielJYbVg5TGxwQUlBWmNPYkY5eFNEUzg2dUhXMEVDTjA0?=
 =?utf-8?B?ZU5tMUZUQ3B5Z0g5WFlHUXAveDJvNUxjNitZSGd2K09lS3kxUWkxTG1NUnkx?=
 =?utf-8?B?bFVsSlF1TTJZQmM4RDlkK0gxelp5Qm1lemdWSDI3MDdmRjk0TS9xZ0dJUHdT?=
 =?utf-8?B?QzUwWVkrNlB5RldUK21sckk3YmRxdDdTS3pPS3l0b1l4UG5tQ2lqa21ldzAv?=
 =?utf-8?B?dWtqL0t2bFpnRklOMGlEN0k4SzlPbU5RcEJQU242d1Y2VExNeWtQdGVjM2V2?=
 =?utf-8?B?UFRiQ1lEZThGRzBHTFg2OUV6L1pZVDJXT2xRNWNBQ0ovV3hRWmM5ODFFSmN2?=
 =?utf-8?B?VHA2Z0huVWpySlZmR0Q2S2paMkxpVzdBdjN6K0REN3pEUXVrN2RKVzVPUnN5?=
 =?utf-8?B?cnJMM2hBbzErbWlLeHAxQ1JnUDMveWVyeFlJQldvcDg1eUxQU1lKazBVb3BJ?=
 =?utf-8?B?MFdCRko3NzBMQ1ZOeit4MkJPU1ZWTzVFYUlFbzlNRWcxTGtEWDRlTzA2UEtw?=
 =?utf-8?B?MmdDaklqV2wrVFdpY3RLVHhuaHlpUTk3Z254Y09VdCs1R25ZZjZZaDVCTmdk?=
 =?utf-8?B?MmpGRDFKclFxeEZsRm05dXNMYTcrcXd4blFjamhnZlMwZnhpN2ZrWE0zZXIv?=
 =?utf-8?B?RnlpSzRYRzdHaVg3RnNyQmhGeE15d3BQbGNHa0xSZTY2R0ZHellWU010VXdm?=
 =?utf-8?B?ZVdqWEg2Q082WXMrM2ttUzBUVnkrU3FhTE5oT0ViM0tzK0NsQi9BeGhyUFBX?=
 =?utf-8?B?UTVKRG9PRnpVb0ZPczlOUC9UNmxad0RKNlhpSWNhN3c3K0Q2cU82eENjemVz?=
 =?utf-8?B?QkgrR29xYmZCMEJPRHIzd2tvQ2dlUmJBMFlPbXNqNmRTcEJHVDZZNUtWcWlW?=
 =?utf-8?B?U2cyRDEzYWRDY2JoNG9jWFk5L1ZwdTZTZ1hxdkhsKy9vT0JFcEU0aldDQXpY?=
 =?utf-8?B?RERwWkh6QUVTenJMcGN3VDBsdHpSVVdMMThoRi9scTErdGVJcnFrVThxYjdk?=
 =?utf-8?B?NFBrQVJvNjR3YlBMMlVWbXVmbVVlWWlJMWJlTUVPanNYK0h6WjZzZ1hPUDJy?=
 =?utf-8?B?SzhGc3FDLzBlTFZUekQzZjhTQ0hYaHFoOXl4SXovaC9RRUo0UEl5ZDFKQi92?=
 =?utf-8?B?dEk1OWw2YW9PSXdwRVV1bmYzZ3k2Mzk0MXlNSU5OVSsrMCsrNHFyWVZuSGpO?=
 =?utf-8?B?WUc3cnN3ZHRCcUxzNko3UE4rYkUzUVpNQVM3UUFBSWdqbWV2RDd2OTVOSVpF?=
 =?utf-8?B?ZXBCYUJWQ1FHbFhwaHVyYTUvMGQ0MHQxMVhQZExaOTgxT2xUZ2hjTHAzQkV2?=
 =?utf-8?B?VTNDYjJiYW9NanNwd1dBYWF1dXhnc3o5S01YRWVRZ1cyRUFTM2hvWGE5bHhX?=
 =?utf-8?B?Z1VicVhLZlYxK25HeVpycS9hQjNlaDc4RXZqZGxJUk1jWDg5dHJGMGY4eWJX?=
 =?utf-8?B?TVZKMFNhTlIyMHJRY3pTTXo2cXZyTElIWU8rT0F1S0NiZUd2QVl6OFRrU1di?=
 =?utf-8?B?bGFHeXJtMW1saDNiNXZpR3hZeWhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <895492DB82FE8E42BAF7D778583BDC84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dfrrzrcJDxOZUMfh2NGBURlb6H+7V7IUncXfQeu+uWkrgKEF8/g1LMAr9Exart5e6lRGGeBcA6kzBKH+6x64COwmSwyPAaXburuK44mSDEa/qdSTmRMdRR6PvaNHx+33YNH+5FzpTqJiKunfi2MCMMQGEU+/nWHxavkrcbUhWQ1kApAAcaT1h9LNSgkKme7LguiS4ZseFsrSGwlfzbaj8vRUkuvKsPceql9KOk3SOXGrVchilXtgRvj1pk/QMv22FXgsTY7fjpX2zZBgEW7RcRnQeSEqLqIGSqHYvuLPq0Ubc1zT3ZkhGePRSlge4dc3WLiOwO+5xsq78+gJyg6aEhSCzPgpSV2atto0parF4X+L/bTNKRAuakM06iSktdFiFtWESnFcY7oPXGfbUcWPDac3MLhHyNd2rdaJ7YBBszyptud9ijZ4TzSkanVCKiHc8yY7dbx+Sb2MGLmpZ8uz4tda31eqAb/QWhisVxvngRMj3gJByN8PFH/z8w8rJO0QJukS6j3AgxHHEgRHhSJf5f7Q8TheUbCrMMuoHM/WJvaqcZ97WP3k8zh4/1z4ucXncjAdjbAFEyw6ecy4m8Qc02eUPsqVz/mhvnfRzfcpfl7scZjErU9PEQlkIIOdK/WMMQ9pWxhfzv51tJw4FEfIw9YX5gmgTRCi48Pmc/WMT4+6V1qomlb8uWTyaSJ4NUjPg8g/GnTuww+o4JCM/ZIoU4zdPktwFVGLMQ0EkieiAW2OyCZYv7/WvStE80SQL2/iZP92d+rvjvWmVoNZTlie9SnjRIC3YBs7eTSFAjaJ27+ykvSF95vggYWJjLBKtaKDMrYIQ1F3QeKKMeEDfgHn83gbxzxBh6sMcOfqKMa/WH4l23H4ACpR0I8gkev8G4q7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d8265-c276-4a4d-1672-08db5d3d0b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 16:28:17.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpsbTL4myhfM8wLw6KMGZU8zrx6nmVtZjzxNC7ib5jSRLPNQkP+98iVDh+Yg4a1t7il8eZTH4wuAbH7wdt16NJBeXp2pH0zAAngff1vH72Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8787
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
