Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67E6A5506
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1JCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1JCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 04:02:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1A7D9F
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677574966; x=1709110966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eEAfz5JIxeaIW7nEWU5tRGjUCdxf99D6St2NJprUcBM=;
  b=ZE9nbWrJBADVIp59zk0QQM+go1wVaElHKKUvE7vVXOYuaIcUO2l836lO
   mthmWBINk7mVzqc4mJu4Yde/JvDUF6ayDp9Z0HOIL08I77GpE8ViXEdUN
   nJ3YZ7tJD5AgIlwwc019c/IhWysAi/l6dKjrIdd+0L0q4rvWTnpUzR870
   wQMJ++kzZRAWALCmxaQeSDZZTG5Z3sAQ1HNoarswRDxGJK+S31zR3mC1A
   Il9iPEi3jAdjuhusqNvMZ2PTBNPLiXrcei2wZWMEgUz2pffdvilQtRVZp
   pBA/uF0+m0CXQdop9WIDodRjEcGXn5kvIJWcr+YgPp6gDzQiecCPONH6O
   g==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673884800"; 
   d="scan'208";a="222690961"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 17:02:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVygipP4Hkl6lBHbyx7eOFYMqQJ0Wh3g6xvZtIhaY3CV9a+i5eNxn9W9zDJwydphIvmiXJOYhEffDnH5z7J2fetHgLxwOtyL/V+WGG1zLa2XlvjeMfk6AzTYh3Nhb39QTDrO5e6qS0Za5k5SIb3R8BIGjzrGU2zQVw0RDpTNgs4RDjmJQXhhf2+Qz/Tp82xLLvJdk4qdj9FQR/4esNLi41/8PYy44MdZIl94a7pa5ftTXFt1RoHwWd+9sDdJa3UTOryDI35hmQJY8KCxacbPyTPB9Oi1+5tJigNX+D3rCdItliX+ogMxv6kcwObXVsGXCdRumjNFtHzuBVktDKtqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEAfz5JIxeaIW7nEWU5tRGjUCdxf99D6St2NJprUcBM=;
 b=NGWtC7ybJYEPmKzXnxRCaW9AKejBiMHlwiRnCuubIkCb+NGwEm0ZNkZqjN+F/aB4ci9/5arvicOA2CBcz6ugsR+JkLL62aQcWvdy1ck9DM5+TuDVOXsRRuemoOPj3ke6is5Zz62QT/be5oNzvuK8oOn6hzEVzCtLJKbjn8GWz9GxwSDAfBed3hxuqCAtjWZyiwV0+9iZXvYQd1XMemeYs2t2EEZna0rlt2IW3KwHRKPvw9ioRc8HZdm1Niioh7e0tGXx7F2YMlBaBEv9No1JlCEIaaU5Xx/7GmiZKDKSx+BYCnCqqN1GE6jzEOrLasonbEjrmoJsbdyOOL6CzxRqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEAfz5JIxeaIW7nEWU5tRGjUCdxf99D6St2NJprUcBM=;
 b=OwlluVT49BqUqn+kA+lu9v+XfstJBu7bzl0G4zYzSiWTtHuLQtcoHL11flEQUPSg3TEBmE7h557I+07zCUacJf8ziOUPLqadxzebH6Z7ikmj/ABawpgrGoM/5d593mdY3HHy8QvIVdSxnzqbuSO+v/sPjX+d5Sf/HhuXGcjFAEM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7948.namprd04.prod.outlook.com (2603:10b6:208:343::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 09:02:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Tue, 28 Feb 2023
 09:02:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Topic: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Index: AQHZSr6bjTSKtJTDQUqt4wx+EC/yEK7i+W+AgACyHwCAAGXHgA==
Date:   Tue, 28 Feb 2023 09:02:42 +0000
Message-ID: <4ef88b3e-1352-e3ca-9e5a-a139ba30c498@wdc.com>
References: <20230227151704.1224688-1-hch@lst.de>
 <20230227151704.1224688-7-hch@lst.de>
 <4253c978-d19e-5032-913a-dafda476eded@wdc.com>
 <20230228025824.GA26819@lst.de>
In-Reply-To: <20230228025824.GA26819@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7948:EE_
x-ms-office365-filtering-correlation-id: f55ce4fc-3c06-4828-39fd-08db196a8cc3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQcI2N5Is9gLK2LVKROGIVRm038hy6mch6Am02B8urYMIeZ1SLCZMD9XE3bD1Aj3Y7BHCtsk8FRVbdPpJUMPRl0BvXRavJcpZlA2tDOhNuIhcWyjkDmtkUxamdyYLa1OBA7ylOco9cfX4/Msi0MUky035JFSajYS9qeL2e5iTqELrlcwJaeKhLKv1xFFBUgO3cDZOM3YjB1wYGfzBKQpw3EUCXTLkaqfFbpdnFk0NnfP7QcRZix/XURCtP6AHq6FWlQ8MNLAm8aJjDe5rrQOBK63hMk9N2x3BmcDlz9ZBfWUYh0gsCfT2GJCY82k7dx8wBWonGGllexgDluiulkzZsn6sqMpP8FBlLh+iuCHfuH39axBOJrGTHaRaap5cHcgEoggOQ+dXYhTgVL9dlD/SCicLFkgckdZJWInOJn15ljrNAaT/TGdJZutgkhJ8YV/TC7KxbFiI8jF3k4xb7HPqC6rrWgaLX9CESknFs2655U9b5gNv2+ZjGd3/NGwFrMT8woq/yfI06g6INId15aE6dDJWCRiXvtz6eZY5oEXLoGQnARghFz16A0rV+RC0L2bwf9zk0QsKAm+T9jU1o4LDA37crmNXr8YnPEyXn1dhEdx6qFW3mOY9rQGdhmKzLNgFgy74841hAr1eLAtmdrdszNfSyDobNYrJrXaphpcsLnLD0hgDteS66OT+mfa1E5+WdUUd6yVu4Ow+l9Ng0AvM4mkZim9IiM0HgqbDRqkxBtgj76rjngtF8MvrstQVWGRSzW64rJYTUiJLLyZzzWthA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(36756003)(8936002)(5660300002)(4744005)(6916009)(6512007)(6506007)(38100700002)(122000001)(53546011)(83380400001)(186003)(82960400001)(2616005)(54906003)(86362001)(71200400001)(66946007)(91956017)(41300700001)(316002)(76116006)(66446008)(66556008)(8676002)(478600001)(4326008)(38070700005)(31696002)(64756008)(6486002)(31686004)(2906002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0JTNFRGOXUxYnRJMWNjOVJ2eFJDaHJkSktwaXFabjlTbDhOVzdqRDZRd0VN?=
 =?utf-8?B?eTNXSjQvdzh3NHZubytCd3U3YXREcUg2NitUcWJzOEtlTWh1VWc1bWNTY0Mz?=
 =?utf-8?B?VTlLMXRYU1FLYVRwRFRRZnlJeS9NNVhQN0Ztb3F5emR0ZG9XUEJRaS9FdDNs?=
 =?utf-8?B?TmJkSE1EQ2tjU3pmYW8zK0o0SnBSQUtiU2YzemhBd1BFd2lVQlhXNDdiQXdF?=
 =?utf-8?B?eGk2RkJvOU5rZmJOcktlSzY2QlcxbDcrUWxQWmJZUGtCVGE3YXFjUHU3RGlM?=
 =?utf-8?B?WlEwOTUvbFhRNXpzMjR4bXVibEVTS2tHRXVmWUVQNmlxUFJxMmdVR25JN1kz?=
 =?utf-8?B?aFVtaFVZMFF0MjFhbk82aVhYVVVNNUc4dUtqdjVkS1Z4RURPZVFsZEdORndu?=
 =?utf-8?B?MmF3b09wNjhDSVJWSFZpTk1wdTRKSGFKNVNTNGhQcWNUNVJoV3FPVlF0L2d2?=
 =?utf-8?B?U2kvNHFhZEd5S3A1cW5yK1EwU0tnaE5waVptN2NGMU92cGprRHJQQ083RVZ0?=
 =?utf-8?B?a2VTYXRYRXkrSjVVRk9tcDc1bjJaZE55SWFrQlpLUzhhcno3amFPbi9wZ3BG?=
 =?utf-8?B?RXlETVZXaTNjSjRNTUJKOWhJeFl1M2xFQmp0akQyM0R0TkhDU2ZYcmJCeExu?=
 =?utf-8?B?WkNJTUQ4SU9RUURjWjl3NUNtMll5MnBXSXpIR1o2SW44K3kwei91U2ZHSmRu?=
 =?utf-8?B?TEIzeVBrL1h4MEZydFU0UGZ4SlNwRnh5b2xtZHFzR1d1Umt6Z0hQdmtyQnh4?=
 =?utf-8?B?QkFhOExpaFFsUGRzV0MyQTdYTHM0Q3pSNGtPYUFpT045c25OTkhBdlhpOFUr?=
 =?utf-8?B?aVpWTFkybkNZN3dLWkNiNHhvMWJ0WjFPdEtBckcxNG1jSnVuaU9GbGxPTHcx?=
 =?utf-8?B?NHB0SElMcjk2QnRnMHV5S0JTUkgrQ0lSTU8ydEZhVk1BMUZaV0IwcU1XMjFi?=
 =?utf-8?B?L1Ivd2k2LzFaNkhDeFZ5TENtdlNKMi9BVm1GclNzWW9YeXU0RkZBQmZySzVu?=
 =?utf-8?B?U1ZhbzdKcmIxOHBvaFVOT0d3aWdMUzd5cU5SN1BYN2tkZHU3VUZQTTZRTVEv?=
 =?utf-8?B?UFJjZW5HSG9BcU4wbndrclhqUXhIRU9lcWcvTVhzUWxvZi9taW5tSWFMMzBx?=
 =?utf-8?B?VExHdXFDakVsaGpnRzloMy9GTGpQUVpZUnFxMk1GbSs1K2hWMUhrT2QzTDlZ?=
 =?utf-8?B?QWFGSTNKUzliQlEyZnM1NmJoZEpQeW5yeFZ0dm10ekJyd1crTkdRRG1BWG5G?=
 =?utf-8?B?Z0ZERDVxZG5QeS82Yk9KK1k2NlJBa1ZzUE1nWXJKOW5tbXZXdVk2MXNyc09z?=
 =?utf-8?B?RURHRTVYclZFWk9RNFlRRjhZQ01VVzNGRjhjaFhmcXFoNjA0UWwwTGN5aTdZ?=
 =?utf-8?B?U3N1OG9LNGY0cXV1aTkvUGZrZ3NXaUtzbWRTYTl0bmREVHBtQVphclpjRVUw?=
 =?utf-8?B?eW1ycGZxSUk5eHZ6ZzZ4OEZmRjZiTnlxNTRqTW9WMW9oTFJ3NC8yOVd6cWtM?=
 =?utf-8?B?aVFHS2UxUjYxSGtCWVBoNU1GZzBnd1NQMGNuK3NUcEVTMjJVTlE0N1pWeHlY?=
 =?utf-8?B?dFFLQlB4cUtSTWozVDlQL1hOV3dsdUpMUTJnWHIraEc1VktJenI4dHVkbEpz?=
 =?utf-8?B?U0FyNE5RVzVBWlRjRmlZWjZDb3hCdkhoQ1ZmOHVtZWFrNzA0U3lCdlp3WTM5?=
 =?utf-8?B?d0FQYnlvcFRJYU04TWNzd0k1ZUViaEpFZkRoNmFiYm9kYkhmRUFyVXVKeVBQ?=
 =?utf-8?B?TUJrbDNJR2I1NGQrbEIvT042OVdpSkFYTDhvU28rWEVzWkRMK3hzUlNhR2dG?=
 =?utf-8?B?K3M1Rk96MWI3dk1JNVVwWVdJNEkxOGtTZ1BrRHRtbE02STJOb2M3ZnZnUzU1?=
 =?utf-8?B?VGFXRFRPaXB1V2R5VlNyTVBwQlcxRStBVHI0WlQ1c05EMFl0NG0rUWEyYUxy?=
 =?utf-8?B?L0c0emJXUlU1anAyc2dpbWxEbGJnbE5IbGttL0hSeUdCbFl6TWxJRUJVMTc4?=
 =?utf-8?B?MGkrR2JFZlZzN1gyUlFuWnVvNVJuTDFsU1cwcVF1blk1L3c0eEg1TlV5SGtQ?=
 =?utf-8?B?SVA4ZjkzOU9TRVpMV1ZtMUR3cFdMbUlCYkV3OFZqeHBzMFR1cmlvZ0EyNW1s?=
 =?utf-8?B?cEtTaTgxeHRUZUhBMmpJSzIxNS9Hb1I4ZjBkZ2huNmNOdjhCdHFkOHhOWW9n?=
 =?utf-8?B?N0R3emRWRGtKczhBVElWSHdTdnZRT1ZnSzFCMkh6NVRpRnRzNExhN2JvOUFQ?=
 =?utf-8?Q?B6VsmxjhUwtk6jYPh1PXkW4Qm5ZVzqeoNYUs4nzJ7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0C439B8F6A8044B52551AF34986C35@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wAp7Fho6VOVdhdvvEWwVEL6WuJD3KNOEYx828iiY/sY0bEQUu6Rz0F0rjHI3KXdYsnwmBNJKmqNgE0yHPexrA6Cdfbw9DtBjnBjuU9jzFf/KFejR06g0REN0wlJOunf2VUyUCVTVmGkQlvWwHHBGhMcjOKdkPttHg6ObdR/kBCsuv1Bm5Lu7D9tKIC/CWPkeJkLV1cXn+xCbCsJce7bb8BfBQdVp4QQrx7Y23c+L6YOtGA0TCPnlMzUgGgSBHdy4tGx2PgmeT/jitZeUn6Q0aLKz8BFcL2JO27TOKfhpMRV6KJ7xVWASzCVblN7+HfUF29UyUMrTfQ2WDi80xJJa3aK2xgx24dQZYG5Bi+5Zzfk+5ptsX9U0IHWbZ46ffnf0ixebZ0vOHlWBT1uQCSWOIg75C+AglBqs5aysPbDVGWRMoLrCWML2VoCXG/adDlCCE+q7Gz6nhSztQxjZFvtx3Se6lrzT0qaG2Y0wWQ8cKPl2YNt6Ia/bcdl2oZE6ukYRKGLCBA6QxOKAEyiam1WXQNuOJy/hoP3qUY2Vq28h0rKs+xmDeDmm5a00+99LRzIjgDwzFL+RiY2yB4NKKvPc9MdxUo4zpwHN6/0vUqWmsnSUV7795ZY/I5alCLhyKtLQ8c779Mj27sbyfhsIngF/cXA3hgLSKZbqwpsoVSKG1W3WPFfLr7PByfJ5mRR4nmf7bMaTJjlCR/tNmrZsoiCCcdoidPr3IWqvvxdK8dzvx65YONxbW1771zmibd68hfRuVkUkjoKIQcLMlFDwrT/qc2wMfkEGBLyW2qn9bud8zkKsoX3U2RnAdD6Mcjpi5aX+pSHm3lUOyEwu/gSTIEkP8iNZd0lgsH6jg6Rng9QZ7R3iSC/Go5rbiqXOlHsWSKAP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55ce4fc-3c06-4828-39fd-08db196a8cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 09:02:42.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfFWAuNf28yQ4iL/mLsW0Zb22lFBrRAWXC7PK46mhQps2/pnw2vnXE5lrAxNT6qEnqyzXTB9XI+fqBQgYSlzscSftfQB16AO0ug49mYAhmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7948
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjguMDIuMjMgMDM6NTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBNb24sIEZl
YiAyNywgMjAyMyBhdCAwNDoyMDo1NFBNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBPbiAyNy4wMi4yMyAxNjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4gKwkJ
aWYgKGJpb19jdHJsLT5jb21wcmVzc190eXBlICE9IHRoaXNfYmlvX2ZsYWcpDQo+Pj4gKwkJCXN1
Ym1pdF9vbmVfYmlvKGJpb19jdHJsKTsNCj4+PiArDQo+Pj4gIAkJaWYgKGZvcmNlX2Jpb19zdWJt
aXQpDQo+Pj4gIAkJCXN1Ym1pdF9vbmVfYmlvKGJpb19jdHJsKTsNCj4+DQo+Pg0KPj4gU29ycnkg
Zm9yIG5vdCBoYXZpbmcgbm90aWNlZCB0aGlzIGVhcmxpZXIuIEJ1dCB0aGlzIGxvb2tzIG9kZCBU
QkguDQo+Pg0KPj4gCQlpZiAoYmlvX2N0cmwtPmNvbXByZXNzX3R5cGUgIT0gdGhpc19iaW9fZmxh
ZyB8fA0KPj4gCQkgICAgZm9yY2VfYmlvX3N1Ym1pdCkNCj4+IAkJCXN1Ym1pdF9vbmVfYmlvKGJp
b19jdHJsKTsNCj4gDQo+IEl0IGRvZXMuICBCdXQgd2l0aCBwYXRjaCA4IGl0IHdvdWxkIHN0b3Ag
d29ya2luZywgYXMgd2UgbXVzdA0KPiB1cHRkYXRlIHRoZSBjb21wcmVzc190eXBlIGZpZWxkIGFm
dGVyIHN1Ym1pdHRpbmcgdGhlIGJpbyBmb3IgdGhhdCBjYXNlLg0KPiANCj4gQmVlbiB0aGVyZSwg
ZG9uZSB0aGF0IGFuZCBpdCBicm9rZSA6KQ0KPiANCg0KU2gqdCwgdGhlbiBhdCBsZWFzdCBsZXQn
cyBkb2N1bWVudCB0aGF0IHdpdGggYSBjb21tZW50LiBPdGhlcndpc2Ugc29tZW9uZQ0Kd2lsbCBz
ZWUgdGhlIGNvZGUgYW5kIHRyeSB0byBjbGVhbiBpdCB1cCBhbmQgcG9zc2libHkgYnJlYWsgaXQu
DQo=
