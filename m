Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E96BE6F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCQKgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQKgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:36:38 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08F4E5C5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049397; x=1710585397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fG9y7/Ow/fndgezGxP9Pf6dojC16f1VTWCSfthvinGg=;
  b=J/g2kMq8CDvVEgtPddyHqZT5cryvrV/JpOQt9MTlmMBA3r3v+Jtxa5ur
   kCMOPpC5z0UYGOANBIBhSjrvurBYommD8sVLzeIivcLRZp/ins17uHMVT
   lcQXvsx2wqx5yprdfxuGmIXlXvcPY86C7Q698+nZ/FrEYUj1DIixpHmCE
   pwoifCdy5N185UwXdF8Xpwl7wMp6uSNND+09MSQgoJkSEHNsZUWxwtVYi
   Bjq86NRu/Kc2D2Av8fXJ8RDQhWDvCcuHs6Tuhrbw6kYPf5Ru6AAOse3Mc
   uz89rY0+6l8g0NPERcDsGuI2alBApYUm1aoE0ALgf5QsU8FPr3Bjfvp1x
   g==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="230817797"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqfz1ZB5SmxqOvYLBHl3VkX9Hd4Q2ti5ygeGnN80tJL1GKqBv2KAM7+EtfrKqDdDj7DPiEdlCLkLK/7k6i8XxAb02N5Ja+eeaGqmBMqYzY+9UIw7CfeosnbHLdYofzcbFUIML8QVxnQX642mPrhULtPtaKu3gBjCXw0ds9mdIMe8MPnBctruoiY4kKxG11eznq0sQ1rRD85sJRP4dyCe4SJy07ua1QxB8L4Ukbvte4187caJi5MdmtGPYMp47Wo2OTl7WxnIxmWRel9sI9z3/IvALyG0ePIvm79NNwwYZ045dJZerbhZhI55cToiUg6ilsT2esSjOK6QKW4dzPfNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG9y7/Ow/fndgezGxP9Pf6dojC16f1VTWCSfthvinGg=;
 b=dUIoNX1PsHYn8OCPv+18ClueupJRdsqk1Mea6Efj9R1KZE0II8xjcwNgO6TT0RzwpfYSpN/0zZbMGd2Q7iR+hKmPmqhYQWzcJLseNklM1G6BLvNSghLZBErAHJOM6mSl7WhJyguTtQ1sA615o0fWI3CHqZ+ZgXNVoKBZ5MebrkbnU6utEQQ2o+Fm3SLFde3nwNEviombXdB/FJxZFhouoVuCxGMyzOxlbeWt+pHPuot95+mNAZgLlRPP+ODChQldgWFsL6QZ5o5RVK6NpKxZSsur32K4R7zAXYnSa68et1AjO4aCL0hGrdIq3wZgwUGKSKY64nxoyWStkglSrJQEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG9y7/Ow/fndgezGxP9Pf6dojC16f1VTWCSfthvinGg=;
 b=fang01Wg0o8zMgLfIfI3GDDbMVZU4pzrXJ9hr5wqVhj5Qm0vukrFIzQs0LcjO2kG2RnI2pyyi/fdS/mN5DM55GJp/MqmpscIzj+9o+u7scRtYb403hxaTLpHmIi5qPnNqvHjStbi2B2Zidv1moFlaNR96KFMtvMJhyt1DNpn34g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:36:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:36:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/10] btrfs: remove irq_disabling for ordered_tree.lock
Thread-Topic: [PATCH 09/10] btrfs: remove irq_disabling for ordered_tree.lock
Thread-Index: AQHZVpZ05sfPLWffsEe3HozNq5pu667+y4MA
Date:   Fri, 17 Mar 2023 10:36:35 +0000
Message-ID: <36f29a8d-f939-a4c3-414f-091131f9aa92@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-10-hch@lst.de>
In-Reply-To: <20230314165910.373347-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7545:EE_
x-ms-office365-filtering-correlation-id: a72f79d9-2d52-446c-08a5-08db26d37b41
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emj/vVoQGJj216MFTU2c0x7pY6gofpNA3i0LtRSe2uOwybObUiHtao9dwkx0YmnXjDDUkCZWFbTXooIqI+hHg2WmUA57RM2W1mp+sOkkE2BzSPylt5ftzjSeZXw2vRgx4fWccmPbgKiwITNJ0ydFm+F5yA8gqeQM5L07LShzz8Iq9o6zGDAaMbXZM8WWgKOtmXwS/n6VkwXKbAWB4Bu+Ouz7qTdHdA5dZNw+ylYd80fbKPfSkZCH5JqOnOAo9hiFaXrIBPsJ0HuOOKETWVpAFtWTD5VOh36nO2NOcRM9q+Y8JGz8jyGJM53hnUmvSqNLHP4vtYfQr86VnYBdZHerUiKjtajt3JaScdgIlcB8gOv6Q3ShZ8Xu+n9uoe095BvetMybgymFkumcFLz6KI2XENPM7VKjRyCiQhaH4yka8hBDOapa0KPBQ4rn+8B7z13RYqKW6BfvLr71C/1+qBPj4tsCxaD7GhS1T3IKI786pPnS+7rSYZ9mk4AKOIVThE3K65iLyRPvfCcXelyyZCmNIjKMBzjgTzdxGKxTE73k4o0n2oSnf45p+c2eUZjKm+k99mMYOiq3uwyPbEYO7dKNN7G/o/2JYVeqQYXAeQveBFg4gpbhOeGOSTNYSdpQ7R29ZrdlhZMCMv81eqybvt4q/IPMHUmgRatB8qe1hPmnl3FBta83AsZKgMN55W4LnNNT4PsgK0atPBJ9P3f8Go1FOF9kJ5NnGJHRtC6b5wSBdfNW66oH4ZTz9ScK49dgjhvD9rjaADEz0SpDbGcF1utKoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(558084003)(6506007)(66556008)(4326008)(6512007)(82960400001)(53546011)(66446008)(122000001)(2616005)(83380400001)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkhBMVRvcFFESkpFQjVzWlZXRWxOa24rbTlxZ2s4aDRSRUgxUmk3Z0FQWEow?=
 =?utf-8?B?M0k0QUp5WUVPSHdYZEpzbUFoNEdQYWtWRWljUmFoU0JTeVZZZjBDMm0yVldG?=
 =?utf-8?B?RmZUOGc3TDFxLzdPZVcrMnZGejNhUWFNV3BWMmtVc1JHczIvRWdsMkJ6SVNG?=
 =?utf-8?B?RHp2Mys0SjhRdzY4Vnk1eDA4ZTJVNkVXYm9rVE9pb0RtSUhFRy9NS3FFYW4x?=
 =?utf-8?B?UFJNUkt6VllLOXpucVN0RmJwL2p5L2duTzhQVTdRYTNRTkJYTjN0UHRpaGZJ?=
 =?utf-8?B?YmRQaWU4emVxVkZMQXFrNm9KODloRG5rcTgvbmRINytvUFd4dDhuaUlNd21o?=
 =?utf-8?B?bFYrSGhjeDI5UUJEcnFGanJ1bWZHV0VpNzZXZE0wWW5FUndxZExrNGZsdzhO?=
 =?utf-8?B?N2ZpRDJlWjlCWGQwUEwxVzdrcWhQN1FTdFlBR0hmUWJ0QzVwVklkclVDcGhw?=
 =?utf-8?B?MTNsanBsc3pUSXBPRlpNaVlRRnM4eDJJUUJkTlBrSzQ2b3luSVAvMXBVRzJY?=
 =?utf-8?B?dWJ0aWt4TFB0T3V2djJnYkxNTmMxZW1MNzE5Y0FGSTJLVU9GSTlQS2RlSWNk?=
 =?utf-8?B?MENlOEtjM0FtU0FpT0ljWkpSM1hiT2VlK3hzakRaSlVhQVNTV0xEYXZwa2tI?=
 =?utf-8?B?cDZKMjNmbTNyVFYyTEc1ZnVaV3ZhSFFMZjBLaVFyM1Y1ZFJzSkFreStVT0s0?=
 =?utf-8?B?M3AvWlBtUENtTldCMk5MYmtFbDY1Sjc0RFhtUHlzRTBlRTk2UnJNVzNqbyti?=
 =?utf-8?B?QVhRSVd2d1UyWWJpd2NXcGp1c1dneXJ6OUlhVzhBS3BqTkd4bDlWSWY2U05j?=
 =?utf-8?B?aFlMQTJYdFUwSGEwQlIza21FdTBGNGJKTFd2d3Z6a3Z4Z2ZsQTQrV2JRRGNC?=
 =?utf-8?B?MXlBYkpiSXdLKzBwdStUTyttYVJEZXNRYkpzOVhBbmZCYm9vdjBMQnlLdWgx?=
 =?utf-8?B?NUVIWWcxdEhBWkFyczRKR3lyMEtSaE8ySkFVTEtCdXJQOUNlTXlUWW1Dd1lw?=
 =?utf-8?B?UDVISVRhN053aVk2VW12eklVbCtiR1pFNG4rUEpKSUFsNDgyd2wyNXg2Zk1v?=
 =?utf-8?B?QWZKdVU1dnNHR05FZ3RwQXRYdjhtaWlReUFTNDJCM05PUlExMGJzMFBvSFNk?=
 =?utf-8?B?dVRVME5ydVZpZEpFUnE3OFZTQkg4WFRrbVBCZ2pPdVlORlZZMHp5YXBoZXQr?=
 =?utf-8?B?VFlWMzlMdExqdTF4ZUZ0NmdFUG03SUZ2dnJ0b2Rwd3lnV2l0VGVUeEVxUkwv?=
 =?utf-8?B?V2VwWWpQQy9zbzZ2TUo1VHZqZmdOclBkSGJaS0F1Vy9zL1hYWXZXcXFBekhF?=
 =?utf-8?B?K2M0MUNGd3VlTU13Wm14cWpYclM0am0zQ0xYUlEzVGJURUE0WWxycVdxZlAr?=
 =?utf-8?B?R08xWklhbUxzZk52MUkrOWVrNzNVQW4rbyt6NTlBVW5INHlCQURtQXc3aGlI?=
 =?utf-8?B?U3FtZGtjTmNxQW0yUHd1YVhnbWI5Vy9ZMVZmeElJMlZhazkrQkExRjYwVGg0?=
 =?utf-8?B?L3FzVTNqZmNpQXllK0R3MmRGR1N4VzYzanZuaWMvT1N2T1AvUTBFbTBOQ1c2?=
 =?utf-8?B?NWpOYmFWWnlRYi9KaS9jWjNBVXJiMlVWblF5dTllZXNmOW8yVHFOc1QzRC9w?=
 =?utf-8?B?RWtrek5WRmY2dFA4UW1tQU5jYTZiajBtTnRLZGNyVDIwWVFSZTFxOHpjSVRQ?=
 =?utf-8?B?Yk1GaU1GSVhGdVRXOHFGQ2E4bFBxZFJVeFJDV3JhbGpkYXUwQ3dIbWt0dk9T?=
 =?utf-8?B?YjFIWkljVkp6QTBNZlEyTVYxVm82NWRhSHF0ZjhGNTlZVS8yODFaS3pMSWVH?=
 =?utf-8?B?NHBtRHVYVEFaK0FRaUxwcjY2am5EV3FLVE4xSU8xMFBURDdqWVhlNWFnbjg4?=
 =?utf-8?B?MHFCb3lTekR2c3R3Y0RFdklhU3dwaCtjVW5PYjR3NWloZjIxSDZQY2tCbE16?=
 =?utf-8?B?RjZyZTg3L0NRZ1N0N2dvOGhTeEVzeG40MGxuZ29EZUc2QTBRNVAxT1AxbFZM?=
 =?utf-8?B?NmROb2dSem9UeW9Cc0NpMTl1V3NTeTVhN0tGcWtUOEhSd0o1QlVuQUwwQmNU?=
 =?utf-8?B?MlR0ZWh5N1VveENjbk9JQ2Z2UkFhTW5IcVA3ZkFiNlFXQWJva25HK2Z2L2hz?=
 =?utf-8?B?dHJsVlV1cWhFUTdEL251dE9qWjZBaDNpSUVKK3NNUlhiT1JaVXViZlhsM1RZ?=
 =?utf-8?B?bDhBWW9JM25TZkFOSW8vSmdUaktsMklTWVZlQ2ZSSmpLOVR1UzlhTHlkMkJj?=
 =?utf-8?Q?Dh90KWpG5po5YCpXeIQaLvc8H3B0KPBZx3GBLQGKY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1CB8973B733B4E90F30692FC3E4DA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tbdMl9EjkN9TnzswEcFta5fM5Ec0ojFztdZXa0fX2jkM1wn2rJoLijonh//hDwyqzR3l5seg0YHw9TiyWuNXhOvvJhq9GTk9ZVLPLcKAFsgiiK6hVEtjwOEQeT7n7FKJgEVJ96Toyinljv+9xFR6oNpovE9uM4k0/ze331Cmdh2N0ixr4UEOkhI/csRryJLjAVBijFoPPJhWPH+/aWHqj4DNa4Ng5PseXx4jdkjiXXu2tXgfRwfUmB/e4kVZE1r2CMNDyk+OAdLy0IJbj2iF+4beg8QjKjdeAO5bOJjhvGiH60kFG3p9UZlVjauZcplIMGNZnaskiDLVPdvjCYlKU6FqUXotcKnYldu6c0o0j/ByBGveDR8zPJ6MwwupQw9UQ1jpvB11mG7TxumGiu8mvYfodr7xVw74SiTDOOrJf91l/7Zo4DWzqjeHrR2OETykOE3MPc5YXRUBAHycNW59TXLB/sMD4Lk4juIQKkpewaXFY/NOjK+AvD8fRnLzZiKOYwQU9TMgGKEJEMCqO3HOg5N9gGTfobI7pbcb8agSVpJyus04NxCZceLY+K+KoZJKcZKKy5UxKoUiYOYZWcIepL/KXn9ACsWDOFG1V9ua1fGy/0VmJg48JS+/kzJz3fZ1P/MsacgX+xMz5e/usIRoXHna6Lhj9UgAq8F3usM74+9/SlSzMNiI8Q8mUrhk46K6pS+6lLwP2gN/RVJxxscZxPEXQrPU0sFSmfaPRYISJx9jchwwnywaCjRere5KSgEvTKLTpHqZAptOaTSErPFpbHkRDdooPvRDltSHmpBtZ/tv/TzmZAz754ljfJH6falgTkLTiQvdvsPxCaaLzF2Gu6tw2mP9abJLT4aVClh501F0Ra5AQdMs3wlfls8CQpwcyqGmd9bvtJGNDg8HNcW865ThnBPsoZ2wm0BUnInmnwE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f79d9-2d52-446c-08a5-08db26d37b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:36:35.0246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwDkMohJydh0v+rd3u26mF0ZyJWH2FBvuVqy3Cb+ddtdODFd5iHmRRjGwUTqCM6R0JUc2fjGefPo683FIREgtcAET4R5Nv0mSwajh4EHkKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7545
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDMuMjMgMTg6MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgcGVyLWlu
b2RlIG9yZGVyZWQgZXh0ZW50IGxpc3QgaXMgbm90IG9ubHkgYWNjZXNzZWQgZnJvbSBwcm9jZXNz
DQoNCnMvbm90Ly8gPw0KDQpPdGhlcndpc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
