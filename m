Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C06FBBBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjEIAAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEIAAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:00:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104442718
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683590421; x=1715126421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xtu0J7vJPQxn7R45evWDNIA0HXEmaKyfbDlpsZEIxTY=;
  b=HGmHbBzHGg3JFxCNkfff4pOcgB/9oo7i8Y+qi1w4X9u+37t060KYPW19
   QOUxoXUxNzYPLUO/ndFuurjp7ezn7R01dM3Gcy3X6fFMNIT3pHrPPfsPH
   TMxg9zM3EFeTt5KQG+1jIeV9nb/5nSXMhTmNmzDMX1v1GKk6qO1EpUhXW
   Vo3+iYM9Kc+9JjebONOsH6ommN7kNb3Y7hoApgl/eQASpk14JWdY+7gte
   VoUeKvPpRvfvbWMaj/T8N6bcb4WBstf7PR+FdGAjABfCHswuGYUm4rjWo
   y6BXBUSMt2iNv0kF12JDPwwdWEuQFJZ3OMnbss30eoLWiGwCxg/qQmr7m
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="342232434"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:00:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlsogYSd2q2eZfvyaNMsRReBrHARNfka2isbMdT8F0vqs8Sf57dl9wL8yoDh+oD2hORr2wV6idOjoFknXao2QAyGT03Ub9lgd34+xXpG8WIs+sZxPgDXM6R7DPgvZ9Om5jf3L0XlS1u8RB5wk8qVhWc0M249TI7RZ0T2Fo1fimjVONVTrYMV9RWf04G0wQkMRC5XVLx7qK2bd5yT8RB7m+EsRpZvhqAWhRY1+kvhrlVMDrJVqTKO/b8B7ZdIiQk7qrdmwgQiGiKXUvdwGN1BtkauosPOIDWJrI9g4Id0fSerdM5l1IY6sGyNGS/qaRnQExztqZpWe6E2bGWjRkUnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtu0J7vJPQxn7R45evWDNIA0HXEmaKyfbDlpsZEIxTY=;
 b=K9ojrm61yri87hIcmGFKRDX1UieKZo/CtdTuFsI/kwzDPdTVm0wBO+V7IsK8nrk/GLy4jw545Qim8lB8Kd+6l2DVH6sipWdbZB0sn/a59TOvNI2Y6ubPxPUFfnR6Wc+V1w7akf0WJ4sBorUCnSIFsM1GpJnmGsS8i6QnTRQ4tehP1HbrCw+fxNYzAn2IGa3B61ZAiSPQJ7D/zV3QSWU87ov0xqg+1L5eOJsWgMAvPRsKFNYLQBmWj3cpIUHGHh3Rz336KksnmJ/mXDFxFE2sZ8DM4/WAhhk3aojxFcN/jmkly/ztZA5RGP5ILYnGaXI3DgSqFWoPsXEyngicO+VOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtu0J7vJPQxn7R45evWDNIA0HXEmaKyfbDlpsZEIxTY=;
 b=YDTQNlPsfGtAF/YU5sqwBOnuICP0IVVuCH1vSSL73W/1uPvnGx13R72DHUEko+TMqMVsog2jPlpoA096io7ljVMkMbjhxoN0jBYsBqgXu0lbC+TrS/D6hcpN6PzgMegYhdrAv2JXuBKmd7x7DE0m5nKeoNIfYRVpXdXEji1Bgh4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7058.namprd04.prod.outlook.com (2603:10b6:a03:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 00:00:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:00:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/21] btrfs: add a is_data_bio helper
Thread-Topic: [PATCH 10/21] btrfs: add a is_data_bio helper
Thread-Index: AQHZgcdy1q9dLLQvuk27WD8hEkyoSK9RDucA
Date:   Tue, 9 May 2023 00:00:15 +0000
Message-ID: <fd8a6f1b-12e2-3d92-29aa-32333c7ac59b@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-11-hch@lst.de>
In-Reply-To: <20230508160843.133013-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7058:EE_
x-ms-office365-filtering-correlation-id: afc3ce72-09c3-44ed-cea1-08db50205e33
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwAdIU90zq/oejWAKnjRXIWN+c3AOm1wWfIuDKgqJAihO8YtUDlmZqVkYZHv1oimMGO2MmDjxSZS2B7R2uTjETu8ymJykBzlzT12cttN2Vkwuq3yU4RxBJpQ2OhYPfdqdZMwFrg2jTvuOF0pyxh3EYdcsRvvPX/N3WldnTgC5INWdjrncmzrDK2TrqOv8nlgirsHqczYpJH+g8agdWH6ne6wi6uqSA5968O/21SLUcpI1C/lNQxzTmsUC5/X9cc8d7584VLuzMZPgyZAbKIuZ8ERVB/zeTDtvsjQItuNHj+nnzpFhmrne7syKOWX1m3dl3Rrp8NNT9gJzUnHto0Bd6r899b97qI1VEU6UMYwqTkPYi4Xmn5C3KAbRPElLs9iDRorkyWXDb3fpO6nN5FBDcyN5D3jvMR7dgp2uCo8N1vcD/rmkAbGUGU0FntNBqTHbrHVyXNPnNeL6XeF/O22C1Q8SkULAuAXLT28VWveo+UCye208JA1b+SEmlSXqZBfXbx5P/a0e/l2m+D1nmStis4uFhAzHnLeelLZER99jnE98bGmp9RKA837G65DWk+3dwnekHWwAGEfo7XglFco0o4ZSEZEFkpOj7X0oTu9YYceZip1xVus/KVFTuMHPfds6w+vemuGg8pCiBvtst+QGypCpOkFesAs5Nm7yFKByZVjIDhPSYikZ66/4OmO0iEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(8936002)(8676002)(478600001)(6486002)(110136005)(41300700001)(71200400001)(316002)(5660300002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(31686004)(76116006)(91956017)(86362001)(2906002)(186003)(31696002)(53546011)(26005)(6506007)(6512007)(38070700005)(38100700002)(82960400001)(36756003)(122000001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBCUnY4RDg2QXBJeUI4RE1neEZDRzg1Sjl1MDZSTzJSY3R0ZzBFQlVveEtn?=
 =?utf-8?B?Zi9Kd1NhT3pRVmtCcVFHMzY2ZVd1U3ZHOXBuMmc1N0kzVkFNbkpoY1h3M2Uz?=
 =?utf-8?B?VmFIQ25Zd3BTWlZKK0lkQzl1bVZSVzNrTHBsL1k4b2l0bERHRktSMlg1RkhW?=
 =?utf-8?B?T1E1RkQ0YlVjdmwrMVIxWVpGTTFMcUk2VE0yWXM4cDJZNlNuYS9vcHVobVJt?=
 =?utf-8?B?ZFJaNWYvV2VybXBoKzFmcm1CN3NPRThuMlNsNXl6Q2NucG1rdW9OeVpqRVhZ?=
 =?utf-8?B?R3A4b1k3RCtldkJMKzV0Z01UZ0poNVFuQTlNbUV5TFY5dEtVUGtXSkVIRVFa?=
 =?utf-8?B?ZzM1MFRmUS9aY0pKRGQ0V05NUE9OUGlxK1orMGJiaElWd1hDc0dUL2pXa3Zn?=
 =?utf-8?B?ZXRvQ1B3dTBhZkVHQ0pWbzZ4VGZ3RU5zNFZsdGJ1MGk2ZVczSzhPTWt2S1BW?=
 =?utf-8?B?MEFjWDAwdVZoSnVsazY4dTZDWFQ5UGp0bDAwb1l5RUxXdDg3b0ZtMnpVdVRl?=
 =?utf-8?B?QkhNdlh2ZnNGTnA5aGg5L29EWThYbHJLR0IxQ0lyV0xpeXZJczJNdUJEY3Z6?=
 =?utf-8?B?RklOY3pRTElmVTBJVEFBSzNyeWFsZ1FRamNOMmZSTlpJL3g1anZBMUcwU3Y1?=
 =?utf-8?B?dmtJUWZvcDd1eVJNZDNLcUtMRmNYY0YyeHRXK3h6R0VBY0NKb25xTGlBMjBH?=
 =?utf-8?B?cWRmTUhmeTFvcC8wZVRqalgwODFFbXlLcnV0Tlh6b3VqOG0xRmdWcngxTzFx?=
 =?utf-8?B?RWxtNlI1T2RrTXJCQ1FFMXlzVU9hVmt1S09EdnB2a2pleWtqdEVHajBXZkVN?=
 =?utf-8?B?TFRMVTROWDZwUVBGdy9KMDFLamlQWHkycnRWWDd6UHRjUzZ3a3l6NGxLM2tj?=
 =?utf-8?B?YmxXaVlDRWxNVW9QeEI2RUFOSU4rOU9nMEl6TDFvdzRUUHl0UW1ZczlzRkk3?=
 =?utf-8?B?aGhBbm1tZjdUVGFOUWJXeU9md3dJUVNTSDZ0bkxiVFJBMGJJV3ZRbTVHemN3?=
 =?utf-8?B?VnZINGx2TzY4OTZtNDBMZk55RkFGVkR4UktUNWM0SW1URFhRNmlNU3BKYU1u?=
 =?utf-8?B?TEtuSWJ2MU5za0Z1TUJiZDJ3SUNibmtJYW41NVZqSHAzemJYMXMyODh5Y2Za?=
 =?utf-8?B?S09aN0pWT0ZZb2VGbkhkR1c5bzdQbEJ6K1FuMnJIYWphbXI3cWRrSkQ2S3pG?=
 =?utf-8?B?SXB0ODBOV21pWXVPTFBnVjNHVlNJcFFNRDBzeVJjajJiRk1UNVVMandnM0gx?=
 =?utf-8?B?UWloQWY2VkJLWWoxdkxCMlFucFBkUmlUbVpPbExBUUFKS3IyMUVVMzM5Z3ZX?=
 =?utf-8?B?c1NGc1VpOGVRRDd1QmlJMkJsWjhVSmVDd0c2TDhlRFc4cnViY0dvcTdieUp4?=
 =?utf-8?B?VmNteDFuMmN0MjFyQitPVkVwQWNxaVdIZTBBYXYxMk04Z0lsWml4ZlRqelVs?=
 =?utf-8?B?T1IyVEFZT0JYbjhFNVFEaVc3RFBXT04yWjBkK3FOTS9tVEQvK1VVQmxoOHJv?=
 =?utf-8?B?d1gxR1Y3TkFxcnNzTGh1M1cyZXdXeXU4VFN1UGY3K1VHNjl5UDd6VTdHdDhl?=
 =?utf-8?B?Rkk3TmVNMkJJWSsvbk90eG9XV0JGcnREWDgwYmRlWTlYVjBJMEsyNUhkd2Fq?=
 =?utf-8?B?Z1JCUUpUSDRLdHIweVBiTjF4dXRFMkRvRmxvWEwyK0preE1zYmF5TGtaUW5D?=
 =?utf-8?B?aFkwYW1VVGNHSy9nSnhGdFJmL2E2NllxMDdieVVzZHp6WkFXMUR2UEtnOGpk?=
 =?utf-8?B?UXBZSGxyZFRVQ3FUU2MyZG4rbDRnMlpWcGhGeUR6bGdYRFM0ZGVpTURxRlVX?=
 =?utf-8?B?bUVxb3liZ3VCSFBqcDFvMWk1djB5TmdCSE9pbHdYUTV4K2R0VGh4b09nNUFm?=
 =?utf-8?B?MUdtNkI4UHdrdkxlRUw1T1pZV2FVUFNDZllsNmpqNXRqMGFBU2R0VFFrQWNO?=
 =?utf-8?B?V0dMMkxoS1dFM0swbDZkSWVKYklQSjVCekhLOXgxQkJxZmozSkRlaE1hVjE4?=
 =?utf-8?B?ak8zYlQvUG5YdGc0K045eXFSeXVtVWM5TFFHOGdpeFpOSjVNL3lsNlZTSDlI?=
 =?utf-8?B?QXlmVTJQeG1xK3BGRmdxZjlFWEZpQTkrbFpNcWFuaUx6N1dNN2RnUm8rdVVw?=
 =?utf-8?B?UExuU25LQmRvdlBHSDlNTTNnc3BqUmxBMjNVK0VsejdYUnBQN2pKNmVGZ2lz?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A61A898F134714398BA6A197A1032F1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v4wyZC/1IIE0HBWc+rXvUexNslmotqzt9SewSD3s4V5rinWODMlCbyypFBY/ElQgseyWJIFjJV+6AtJ8KCAGQWuZttpudppPJaDRDaOYy8ek4NfFPTcLUM8D2s6Yys9tiLdMrDbKZdfVs+/E61AEgegvhxKnVa8pUxJpZtafJapDeV/yBE8+IPV/EzR5w5dkmAdfRhVom8FkMZmY5fRojXa9Gr0ZG2gIUyETL5Ft5xPbR88inmN2Lu5xJmkPktW3fxHT6LYgz3QFTIpfZf8iMxHoO7y88ZvaDyLx1z6tnFd2PTFZ0njavnvFlVCcH8aEy1sWqROq+98Iy/aANqgN/cEbq0Z0TE7ciNdA+rN7CHj9BHvOn3hQLBJXanazz+7ZLH3GDgFpnEMMMQ9vr5VxruEZZNFUoe8WLcuHpTGHQ9uEsLCd7L+1WGUHjnX5XZ2cdZWD1LzxOl4axmUM1r7dXeqH0ylp8gHeIhG0YwCMzNfw5Gt2XBFhF4HgvxRAhbJ13AxOELz2eAYnsGuoCiCs9Av1HRznfmNgobi0OkC4X6dzhi+ipw9Hu34hxUOaD8KH3PkklpGYvCfzGcMSof/TXLBPrX9YSsvy/6mk9hVPGf18D7jKyx+qP62MRA2m/5cTMsLc5gQmvrU7N7jawaurseArXFN1y0wTvGIKt+6OJbeczxWooHqCiFDQbsbWEJ40kNdAB5NIZzERGeT4aoqGEN+H1fQqyDn3Xz8E0uO+MzHmbA9wutgj5W3Eq8zzVQWrWKF/oQntJ0peE0KP9kOaSqHxzBbMPCbXOvfHHxzkiHzsaW3fN+/emwP1fDwo6EjvTaLELyK5NPOJ3EZIxQ3Lljmzm90A4jJSdQCVjGf8TdnNgtyf5vvG80WEjPLfM+h6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc3ce72-09c3-44ed-cea1-08db50205e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:00:15.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8z53fzFgF55qlpGVFFyFATI1pw6iT5jnCQDP/Tg2iT8CQp45Gh0GkYs38sz33nWEVnhJ4iSoKBUjBb0taIzGhVmTnAHpe/bZEVM3XutXW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7058
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDguMDUuMjMgMTg6MDksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBBZGQgYSBoZWxw
ZXIgdG8gY2hlY2sgZm9yIHRoYXQgYSBidHJmc19iaW8gaGFzIGEgdmFsaWQgaW5kZSBpbm9kZSwg
YW5kDQo+IHRoYXQgaXQgaXMgYSBkYXRhIGlub2RlIHRvIGtleSBvZmYgYWxsIHRoZSBzcGVjaWFs
IGhhbmRsaW5nIGZvciBkYXRhDQo+IHBhdGggY2hlY2tzdW1taW5nLiAgTm90ZSB0aGF0IHRoaXMg
dXNlcyBpc19kYXRhX2lub2RlIGluc3RlYWQgb2YgUkVRX01FVEENCj4gYXMgUkVRX01FVEEgaXMg
b25seSBzZXQgZGlyZWN0bHkgYmVmb3JlIHN1Ym1pc3Npb24gaW4gc3VibWl0X29uZV9iaW8NCj4g
YW5kIHdlJ2xsIGFsc28gd2FudCB0byB1c2UgdGhpcyBoZWxwZXIgZm9yIGVycm9yIGhhbmRsaW5n
IHdoZXJlIFJFUV9NRVRBDQo+IGlzbid0IHNldCB5ZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBmcy9idHJmcy9iaW8uYyB8
IDEzICsrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmlvLmMgYi9mcy9idHJm
cy9iaW8uYw0KPiBpbmRleCA1ZjQxOGVlYWFjMDcwYi4uYzM4ZDM1OTcxNjliNWUgMTAwNjQ0DQo+
IC0tLSBhL2ZzL2J0cmZzL2Jpby5jDQo+ICsrKyBiL2ZzL2J0cmZzL2Jpby5jDQo+IEBAIC0yNyw2
ICsyNywxMiBAQCBzdHJ1Y3QgYnRyZnNfZmFpbGVkX2JpbyB7DQo+ICAJYXRvbWljX3QgcmVwYWly
X2NvdW50Ow0KPiAgfTsNCj4gIA0KPiArLyogSXMgdGhpcyBhIGRhdGEgcGF0aCBJL08gdGhhdCBu
ZWVkcyBzdG9yYWdlIGxheWVyIGNoZWNrc3VtIGFuZCByZXBhaXI/ICovDQo+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgaXNfZGF0YV9iaW8oc3RydWN0IGJ0cmZzX2JpbyAqYmJpbykNCj4gK3sNCj4gKwly
ZXR1cm4gYmJpby0+aW5vZGUgJiYgaXNfZGF0YV9pbm9kZSgmYmJpby0+aW5vZGUtPnZmc19pbm9k
ZSk7DQo+ICt9DQo+ICsNCg0KaXNfZGF0YV9iYmlvKCkgcGxlYXNlLiBPdGhlcndpc2UgZmluZSB3
aXRoIG1lLg0KDQo=
