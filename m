Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C573668A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjFTInI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFTInG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:43:06 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD0E71
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687250586; x=1718786586;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=hhK0GeU7IReiVBAFbe+CnyeY87p8x8Vu1NXe4v1co6I=;
  b=LURdglCrzpzcTbxykQb0BzDLfUcket+vp9h2TIBb9rpLvOcqBeYlVXvZ
   6wsZwDwMqlxZjRVY1ZPtlkgACFTtSyqFs2Brtuw84mCJi6wsCtp5ODn/1
   slOSt/ID0LHB70CePW1ANfzh9iU8Yqs0GIaRAofyOT/paSHmhUHlMVaaw
   1t9oQ7vc9THQ4xoEd++H/KTrmT7EI8wmOi5+eGPTjVm6cvki9+ZQm2bsQ
   sBiW2YIc0ZWD8giL1Bf/rFKy8GWxvrkd7uKHFikrIRBXF+Xs010wgb0I6
   kAW/mRyH23BBaQEUAMSurxfXuifnnINvOjwCAu4xse4Y8SfjEq05NQIXe
   w==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; 
   d="scan'208";a="235720894"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 16:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddmgjd02qljxP7+2KDF2j01EgOgs/RiHgXkkqtaZpKK5WITFYjhGMslyeM7B5gIJFpRoi8FK7g9F26JRgTIeM5TP5cyvRc3z8MgNcBovHYSUPjXbYj+Mh+CmsetdETfkovJ7/314SzdTDAN7Pgp5e/4qdEjkqMpvlJKfT1Xn7XZyxQdZRrlBCGmMpblmup0PFiv3hyBIRD7xBRzFoYGjkrpQNIQ1PWfO5nZGRDRZQY3uERHSSLp+0tSG9SMZcP12a9w7sSyGh1J2aSMTTjoa6FJ7Yzh117zNV6JE1H+uTwWiJOTw/E9tNUD4Am+5AJikP4KXumz7QKccyXP1kaptCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhK0GeU7IReiVBAFbe+CnyeY87p8x8Vu1NXe4v1co6I=;
 b=K8xfQ1O2+iyE25/ZfRDA55nmjJDHvpn0fgajp1DqoIOG8ROsnm9ruY9oDSpnlKXLin8sFQxLVWUoAQ5MP7qzC4Wl0uU0a91FunhSA+U6AfUApx2RDwYUUjpeNrUnrskexMXsXDqKkUL0k95o+RSbypFiH/KOWpcf17/jBEDQIwbieUDNs8uJqexfYXrQkvt//2Z5Y2O2P49oLCgHsQC0Z24deVtDnpROFmRMFVjhGw7IZKpcW5CdP6vKN354IIC4lY/EcdtBqTCCIcc6HfImdYfKIPco5OnWmXTIvi8/A3emdLWR5J39j0bayRUt5WRCKAghyRUG3RtR7YoSaBYN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhK0GeU7IReiVBAFbe+CnyeY87p8x8Vu1NXe4v1co6I=;
 b=lwTOUu1ostCHK+6cWsiMrF1y8UZBzcEyok8WyO+aGwNxfkEzHc1rZRI9M0umSGbAV6HGpkFqRzreeTdZHt++rK5OI2HEZf6D1jpsq8fg4TP634CHbA5YT76K2twXmZL4R7fpDtekflsht9iJ6h3tKxwtcc1Wd605AetYZvT9sdQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6933.namprd04.prod.outlook.com (2603:10b6:610:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:43:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:43:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/5] btrfs: scrub: make scrub_ctx::stripes dynamically
 allocated
Thread-Topic: [PATCH RFC 1/5] btrfs: scrub: make scrub_ctx::stripes
 dynamically allocated
Thread-Index: AQHZoNm08deiV74jGk+7C5YqpEynBa+TZMCA
Date:   Tue, 20 Jun 2023 08:43:01 +0000
Message-ID: <d085f531-db0c-13ca-217a-a63e804d2ef2@wdc.com>
References: <cover.1686977659.git.wqu@suse.com>
 <93e32d86ead00d7596072aa2f1fbc59022ebb3ad.1686977659.git.wqu@suse.com>
In-Reply-To: <93e32d86ead00d7596072aa2f1fbc59022ebb3ad.1686977659.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6933:EE_
x-ms-office365-filtering-correlation-id: c7014040-0a5c-404a-9756-08db716a5b68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wIF37y1MXBmldoj+fgPzN/G08wPFTdSPLaozcU0bf3hYpmdUl9BZDagjGF7wtw98man1KS0pEStM5dacHFuRpC2YEYyRViQ/K2HRLSB3Rtaq7vP0LjczurgbFPOUHJiPUMUy9fjWLgowXOcpkDM06J7EW9cX/1IbEOA2QgR96Uxo31Hh78G69sjwB29F5nxPMf/p9UFHMGYDUnbe6fY0EvP2362SHAHIpPaDsRxj1TsdyPqpozdss1FnXvWdZCM0WDjQwXXUXNQ0RPMeVsGyzI1iaXszZlS9MBF1NUR4rULkJ9Ql8rG//dkPyJjN40KtJHjrGy+vSqyHWIuJC2QqWpC+sAzMM9w38tU0O97t4OjA2CQl4rVXPyptn6DEn2PuhrVcXr9j4fUTb55vMrITVy8P+bNUwP1zPaoHhTWCfHDebzxKzw7ugiD6y3pxXhg+NPZgRWN7kYEJf8A2tsH8M3e2OrvVJrFQtSnIA0yWpDhYLtapuPpzLUHpJCVNqyNd84WcQ+lepiptr7xX1YR4LINWHXVv6RFFweZLUIsOdLlvPqwkKJfr90cn+2jFvSzZZJiNW/ZLC4q/uIvjBduP+S2OMEhgfGiYOFm0ViO2h9W6v/mh8KZaA20ESOsU3JrLSWqQoUpRYqpV4Y2w+XkWArj7klxnAJErsuold8hOcHwOFkrKWE2igPj5/eirN3w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(66556008)(2616005)(38100700002)(122000001)(66946007)(66476007)(64756008)(41300700001)(8936002)(8676002)(66446008)(316002)(186003)(6512007)(82960400001)(31686004)(38070700005)(6486002)(71200400001)(478600001)(53546011)(6506007)(76116006)(91956017)(110136005)(5660300002)(4744005)(36756003)(31696002)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXdjRkVxeXk5ejdxVzNZQmkwTFRuanAwL1lIUzZadm9RZEt6cUZXQnJYVEtr?=
 =?utf-8?B?R3owVURNMGFyVWRsSnB1RGFVYWVtNHVPdGRDdEFtQjVKRGtiMEZHaDV0YUlF?=
 =?utf-8?B?QzFzV0lWZTdVbGVjeEhJYzR3SmZRRFdqWjdlYWxRNW9EVURzTnlBSHpZdUZO?=
 =?utf-8?B?QWVkTVMxbjd6SElsWE52ZWlwMm9hQ1NWbkpaeklxQ2o5cDNVQXhjdWt6R0JP?=
 =?utf-8?B?RHAwZzg2ZU1OSGlTU2sxQnBnQkJ5Q3lvVWk3MHF2UTIzT2Y4WTY1ZGd6UE55?=
 =?utf-8?B?UTQxR2Y4d081MEdpblZYTmlZMkhlZitVdXZFM0M3cTZBb3h2ME5iYVJCeEc2?=
 =?utf-8?B?b3lmQ0JXTzNQS1o4RHlva0tEY3loVndmUGFFQzZjVmNFM0d4RmowcEk4Vmpr?=
 =?utf-8?B?MCtUL0Fab2lEbUNHTWFzMUNiZEIwaHFsdHFES2o4VUNMZHV1VDNnaWp3OUNK?=
 =?utf-8?B?dWdWWHZYNkVWbEMvVWxtMGxjQjhWcVNVMks2NDg2dDlrRmk5cktjT011NUNR?=
 =?utf-8?B?bTd0QWdWNzE3ZXBvMm5QbW13WWtDL1FmbnNSdjVFZ3hGdUZtQ2xEVGNGYnJE?=
 =?utf-8?B?eDg3blJhU05FT3YwUVppS1hCTjFpVmpjdmkyT3ZKdVpKUGgwcjZkSm12Q1g3?=
 =?utf-8?B?Sm9mL21EQjhiQW5EbmNFbzhDbENOWVhUdHhObHFGeU1qaTJwcmo2Zm9DTWU4?=
 =?utf-8?B?NUlBaklrVGo3eHB0b3prS3JNTndzSmZBdDU5NjRjeCtCbnJlcFZwNGJKYTVD?=
 =?utf-8?B?eUpuSC9rTHkrRUwrMnRkbk5PSnhGdEQwZlVYRUsrREFReDN3Qmk1V2xiejlJ?=
 =?utf-8?B?Y09DVEZxMlJuczJzajBNWWRRL0pVLzR1ZElMQnhzOXlYZFFHSW53TlhYQm00?=
 =?utf-8?B?V1FzNkwrdW45Mnp0c3B1V2FOeGdFMzJ5UlpDdHZPVXJXWEI3NjlDS0JVNFR2?=
 =?utf-8?B?a3VBa0djZ1BtNWplcjBTZFlqL0E2R0thM1FrWW1WVlJkR0RvRWd4OHhzcDVS?=
 =?utf-8?B?NURhdkkyMkpZZmtJa21QWjlRdExBWkpCbjZ0VWFpdnU2WjZITVYza1IwNW9s?=
 =?utf-8?B?alhNaldJZjYzUElLdEtvaHFaWmR4Zmo4dzZDWk0zMi9ndTAyTXlRWGVOa2Na?=
 =?utf-8?B?c09mZUEzbmFrczdxNHk5dGlwR05MOFc0U1dxR2xnVDY3Y0UwaUpqbThxUkJW?=
 =?utf-8?B?Mm1LNzNaS0pLR2FOeGlzU25zckxmdHYyKzdMelVOcmNOZmFPakFUUzNNMHZ1?=
 =?utf-8?B?b3k5RC9KWkRIeVhzOGhQYmtjVUgvT0FNb1k5ZWlPV2poZDVjaFA5Sm9DVXV6?=
 =?utf-8?B?SVhkTUNkTDkwZEw3Y2JmOHo4Y2Y1dDNwSjh4OXdNczJDdXF5SVo5V1pKaDlC?=
 =?utf-8?B?YTZIWkFodlVEU0ZSaW1MY1h1N1pqOTZwU04yOXhJTVVPSEZNaEp4YjBqQ0Vo?=
 =?utf-8?B?TVErdDdOQm9PbDJPOGRvZW4rQjlRWFJmUFgvY3FzRlJwR0ZsSUZKb0hzd3dM?=
 =?utf-8?B?RjFRMGVWeTJhTThNUmJuYVFQUGwwQjc0NWYxcjh4bE1SOWNuTFIySVYzSTE1?=
 =?utf-8?B?Q2NWWTZXQUp3SnJlSE1xWmpRb0RPcWhLUXNPNnRhRDZnZWNNK0MydHQyR0lk?=
 =?utf-8?B?ZzZ5UHdVY2tzVUNMSkFkYVNZWW92UUVYRzZGdHpZbGVQc1pNU0VQZnM4WGp3?=
 =?utf-8?B?WTI0K0JXajFDaXRvaHI4NzJYbEZRUTZpQ2xzR2h6OFZrWFpmWUdHaXdPTUxh?=
 =?utf-8?B?Mkd6MkZKZ0dkUzEvUDAyTmVQUlplZEZWQWhMc2xkZUpLYVp6WnpuK1RnZjRR?=
 =?utf-8?B?OXpRaGhEbTZzb2JJaGd5MGJZWUowNGtDelN5L09FNzJwdW9ZaHp1ZmhqbmFD?=
 =?utf-8?B?b0dQS2RwbGZ2Tm9nZU44bytPQzZRMklWR01COU42YjU1Mmh6VlgrbDZXNlBh?=
 =?utf-8?B?dHZCeUttNG5IbjdRdzVrVFRRbU9IMWtiTDlnY3IxVnlNTXkzVlBoUG1MWlhC?=
 =?utf-8?B?UEVOY3U5Nk9WUmxwQ1JoYk1sZkpBSHQ2MFUybVhZVFNGQXo3U1dmV3Ruc0Ra?=
 =?utf-8?B?Z1VSYUhuQVFvYlM0WkZrdHEycUQ5cFcwS1hZRDM1dXJaRTV1ajkyNlBrdDNa?=
 =?utf-8?B?UnpTQkJ4MVJ0dTZzU0plSmlEWUN4SldGK3YzMG5nNXZoamRwRjNlYTV6c0JQ?=
 =?utf-8?B?Nm1HbFhUUVRwRFNUZ3c5ai9wVW1HVGRiSDRTRkxFVTR1djFGMVd0VWgrQmhi?=
 =?utf-8?B?dzRoWlBXQ1JXbEpTZ0M0MlEvQWpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77BA3E1B25E0F247847FD233A4D8821E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e/ocGMn2whUbiOLIYkD5PQ74JVwcJ479rTAX+Qog0aqZ17hm+zXm+NIWckB8dT0hzssaIuawJN5ljUAbX0lCxKGredacy+s1sjRgzkwvowgh+bQpXvp7a5Dnt6+5hy+AFKko/koIXboWJBHEaaJz3j95p8aqkz3NYpyD8ainVNoIcpg5qwJHzO9rVGQnrmkejM+a9beb4yWpDgkcuRz0PLffox4eyzaPy3meXSpxnL5vc+mL3sJxZqaN6iKzors1pTAsOSL6s0UX1qT/vmJkPzmdqRc46GgMs92qiCTR1m5Gt8W7trM5kWuWcJu4hmkfkUi2daOjzu63WBCChdLHCHlW8pI1RYtlbv+0dR5gmw2FZHHCk5wpvi/voDetkieNXWNmCIYLYZpp05fm0kUV95ZC8tDAALGuhZv/yy1RCICA+Pzj9+3O2Q68QuQ0KbEpXLVVbGXmSUzJq6jYDqg9hVbpo6NGvrWuvhn0nBuq97hUnLYtIKmUhJW9TrlbDRsIvffCfQGEiy+sajDuQy9bRVK3JAPXyxsgv4QVgmy6ph6WZnpql/fGCRXjCwNGblfoCqAT7bJi/cd4ihPKDadA4SfCSd1T/uF0J6P4Ne6s1Fka5psUWpqe5ZHi6gZOSZmnpXGwtIUDjhu5gG9rU4A34F78fqo8lO0waHgcjGi+FQHf0JyPEtHLPFE3OsHqMtQYnkp8ZYlxOuzOtQ34D9cqBWgu+RyNU8JGk236hLKMg4vG62/BC1TbnCqFzjQQ7bpv3X4SJjJJVxesDbM1efHaWXwAXb1QjwIl9HO7yLslwhinNOmDmkxDnHYaSjtjrSOi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7014040-0a5c-404a-9756-08db716a5b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 08:43:01.6759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brrWhm/I+UUU/6PupOaYqTLA7t1HmXVMfJ3+1kPSimGLBlHMfQjvhfU+aWqvrNoz8rFTYJgvKpehD7xPv4/dBk85wIBIpGLn9enbOOZF1d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6933
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTcuMDYuMjMgMDc6MDgsIFF1IFdlbnJ1byB3cm90ZToNCj4gQEAgLTMxNSw5ICszMTgsMTAg
QEAgc3RhdGljIG5vaW5saW5lX2Zvcl9zdGFjayB2b2lkIHNjcnViX2ZyZWVfY3R4KHN0cnVjdCBz
Y3J1Yl9jdHggKnNjdHgpDQo+ICAJaWYgKCFzY3R4KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gLQlm
b3IgKGkgPSAwOyBpIDwgU0NSVUJfU1RSSVBFU19QRVJfU0NUWDsgaSsrKQ0KPiAtCQlyZWxlYXNl
X3NjcnViX3N0cmlwZSgmc2N0eC0+c3RyaXBlc1tpXSk7DQo+IC0NCj4gKwlpZiAoc2N0eC0+c3Ry
aXBlcykNCj4gKwkJZm9yIChpID0gMDsgaSA8IHNjdHgtPm5yX3N0cmlwZXM7IGkrKykNCj4gKwkJ
CXJlbGVhc2Vfc2NydWJfc3RyaXBlKCZzY3R4LT5zdHJpcGVzW2ldKTsNCg0KSSB0aGluayB3ZSdy
ZSB1c3VhbGx5IGd1YXJkaW5nIHRoZSBpbm5lciBwYXJ0IG9mIHRoZSBpZiBieSB7fS4NCg0KPiAr
CWtmcmVlKHNjdHgtPnN0cmlwZXMpOw0KPiAgCWtmcmVlKHNjdHgpOw0KDQpCdXQgaXQgY291bGQg
ZXZlbiBiZSBzaW1wbGlmaWVkIHRvOg0KDQpzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIHZvaWQg
c2NydWJfZnJlZV9jdHgoc3RydWN0IHNjcnViX2N0eCAqc2N0eCkNCnsNCglpbnQgaTsNCg0KCWlm
ICghc2N0eCkNCgkJcmV0dXJuOw0KDQoJZnJlZV9zY3J1Yl9zdHJpcGVzKHNjdHgpOw0KCWtmcmVl
KHNjdHgpOw0KfQ0KCQ0KPiArc3RhdGljIHZvaWQgZnJlZV9zY3J1Yl9zdHJpcGVzKHN0cnVjdCBz
Y3J1Yl9jdHggKnNjdHgpDQo+ICt7DQoNCiAgKwlpZiAoIXNjdHgtPnN0cmlwZXMpDQoJCXJldHVy
bjsNCg0KPiArCWZvciAoaW50IGkgPSAwOyBpIDwgc2N0eC0+bnJfc3RyaXBlczsgaSsrKQ0KPiAr
CQlyZWxlYXNlX3NjcnViX3N0cmlwZSgmc2N0eC0+c3RyaXBlc1tpXSk7DQo+ICsJa2ZyZWUoc2N0
eC0+c3RyaXBlcyk7DQo+ICsJc2N0eC0+bnJfc3RyaXBlcyA9IDA7DQo+ICsJc2N0eC0+c3RyaXBl
cyA9IE5VTEw7DQo+ICt9DQo+ICsNCg0KDQpPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZQ0KUmV2
aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQo=
