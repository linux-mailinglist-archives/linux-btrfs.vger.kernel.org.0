Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10136806A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjA3HlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 02:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjA3HlR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 02:41:17 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121182943E
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 23:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675064455; x=1706600455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Rs0rjjddsDRdxaTlauRjz+Uu1EQvRq3FXncaKoOKYm8=;
  b=rpZAj8zpWEfPOY/ZJzkGk9KVggwJgsYlMTwp5TpbZsOke2Wid3VLx50V
   0mcKwB94jJou4BhIahNzwRX4POXNqsMDYw3TeCgc+fYwnks9sbqxqNpLs
   DmqhIjypbmcjwdC/rnNSBUk6CBxooO0Z1ZTAsZRn4VlsoN/dEZomxu/Lw
   V+X8YHm9gInzfNechHoFEp8QPKCOFtl6GYKhWFcUOjRudInQfREsvblE8
   If3D26ephnauZT3EAdosFgMgGJ1+NoSPWtwin0KsHvOv3s2PQNYkgc6yK
   3oL/pBG9oIuElZGHG9+MUuUFS8Us0hawPBA1h32OmTNv7kPMg1V/cU46J
   g==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="334024452"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 15:40:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPCEf8o5hOwMNYJzeA2jssAm/vlymew1Bv6ZZGXb1Q0OMk1a0X9HCN0hGJfWMmuin9zUj5kry/hN+eYP3NuEco0Hf0OJ/9wjLMbZkYddyRzdVlxheztVCU/ol6jo8cptadwJfKrh4svTy92PDbASGrhQYzNWC8+cBO/lzefBIO3bbgj30Lcq/dappl1iG4aypaU1SX30YLhkU+uEsswsmilTdw5emmw4+g2oaOG2rD+D6OZejdCymk84wrtiPXhNpH+LAdNZK6D1q6lPdoqOoCiy6wJom6/R+/NRmuEHsVMTj+RWFDGskmYqvq/D/i3EJL22UxStVIMVE0gcJdMjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs0rjjddsDRdxaTlauRjz+Uu1EQvRq3FXncaKoOKYm8=;
 b=aQEa7yS8S/hC+13ccuBGIdjWoqslPCKnJvuvXoN93upKXiRqpaXcgp1iXVHcArhYs68HQ4CAfnYNQoKZJma8iJDxSrjsHWSh+c27QoSprZHl+vCsZSA9p6Oh59JNP7jSiMxk4nhWKirU7/CEfDtZ1tdi8eMj2BySqOFXbk4c3Xgpn1Nh7x49VXzqbA2YcLs9vrZgiiyPDisd6PmAdjySVgLrTAj5IP5RMNRdbjajTiKPPUDTyRoAAahITtINYR3NCv/BGZrz/fGLhFuX1s4ukdoBAot9HmXJHQKGhMa/khnUqUfbxG6+gc4TZPT06fFqT2rRilKRFxGhs+6GOjalHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs0rjjddsDRdxaTlauRjz+Uu1EQvRq3FXncaKoOKYm8=;
 b=jX38Dm/jclGcrMcnyBora7yjRkN/waVN8uleTvKpmxJdF2MbuhdNkCuP/s0jIlK1qiVxfwdXC54ULRZW41zudFxpc+B56XmuWEN6Nrq+oeHrW6ewuT9jJlRjeEYh+vu6yqywNjRSKLXZ3TYwdI5W+ctsLvx0ZJmRaE3RBUm/HJU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4343.namprd04.prod.outlook.com (2603:10b6:a02:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 07:40:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 07:40:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: use a more space efficient way to represent
 the source of duplicated stripes
Thread-Topic: [PATCH 3/3] btrfs: use a more space efficient way to represent
 the source of duplicated stripes
Thread-Index: AQHZMvHaPPAQ1TFqqkKBhnrq7MPonK62lnaA
Date:   Mon, 30 Jan 2023 07:40:52 +0000
Message-ID: <9c925833-d6be-a4be-f13f-d6a47ef74d73@wdc.com>
References: <cover.1674893735.git.wqu@suse.com>
 <cb272cf3526cd6271d5c472da974c4bc4662cafe.1674893735.git.wqu@suse.com>
In-Reply-To: <cb272cf3526cd6271d5c472da974c4bc4662cafe.1674893735.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4343:EE_
x-ms-office365-filtering-correlation-id: 9a41fd1c-d854-4c81-0045-08db02955044
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2RAVE88m3wWdxMNZ5tAhwcVXvCtt8oK4gvx9kRaFjgPcMPabF2Nf28nDlC8ahIrOFgfPfRfY65sqG2cW+MW+U6JJAuahWEjkR+Qal/VsKWkoyoy0VS6hXcp8jX0WRVU4lqwaii27/mLrEDqG7pK+Qsms/Uzg2pRqNF/hEwWGTQ4vNBXF1+gTo/hz6F6hKFvvVvWjLDISjxJlnPU8E6URGCdTc9NDCFGUUbBVtvbbWP6PIwHytsAYo83TCWayTHihsFHT7gx8GEdfBfDm/Qod+tWK/R5pvo37pATDMgdt1zleUSVIrOrDQeeHzOcqPIVV3CFQJeSi7ePMYS/pRVvd553tMpYD/NWwjhJjJOh0Kf1u/lVJsD7J4eB/jmU0Vjd45C2krrO9qhP1rl3zTvZI3zQHe/KGTYtfyADo6Aaz4D8bzrdNZ4Et6H370yb54Hn9vXThAnZXl6scBvpWmnHT4Jp5eShCe+vi309sQVCyZBjkdPWSFMJV6KaH44LG6ZDueJjrxVK06QAeXSw1COiiB1+3QlfKnIUDsOkeTBgERuzGk1JHev+hcqrR9kVq6VEUEyXDCF1ArUY7klffPY5WcVuLVo0SYx27fogmyfnCz7zVDi2dJj3wboMLR7dFbSfvqPqgl1gMxJOz4jSIPqR0jGEF0UviIl7A6roPY1j0jMq64zdlSLXCXmWLWezfa8NMIMjs0ko3wFyM6nTC/80bt+a2+z5pNjsBA9aT/FPXhqTaF67w7ggEoCbLHzY+JBEcQKTNd/kppxpKr2cBikZ7Y8Smi9zL5NDf7Ez1CE224o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199018)(5660300002)(36756003)(31696002)(122000001)(38100700002)(2906002)(31686004)(2616005)(6486002)(71200400001)(26005)(186003)(53546011)(478600001)(6506007)(6512007)(86362001)(38070700005)(82960400001)(83380400001)(91956017)(110136005)(8676002)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(316002)(41300700001)(8936002)(43043002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGJySTg2cEVvZGwwUHVFUXc5SjdoNjdicGFUV24rS1ZlMzdhd2JtSURoanBa?=
 =?utf-8?B?Vk9JZmorOXU1QzB3Qnc3UGJPNmdneStMS0hzalgvWHEvREV5SS9EZkZqYWp2?=
 =?utf-8?B?VDNMTnlvMVhxWmF0MitHcnlwbFlUMnZ5QS8wOXNwTzlDdFBEdEVZRW90OXZB?=
 =?utf-8?B?T0trRFJOejliR0dVOWNQU1BPcWwwY2txd2UxSFV6bUhKOTREQkNNZ0Fka0sr?=
 =?utf-8?B?WVpRdmQ0dnNaaDZLbitBVnZTTFNPYXdVZW1kUkpmdmxNSksvckMyeFZwL3k2?=
 =?utf-8?B?WXFCbWI3Sll2dHVzY0ovdElNZklvclhmQThQQTNOWEF0Wmd3WWdFN1hHZmlr?=
 =?utf-8?B?UVVNYk5scjFTNVpWTFUxQ2VTNXBIUlAxZzVqazE4RGUrL1lsSjNTRytJS1JV?=
 =?utf-8?B?dVNxTUxLdFVOMkUyVzJza2YxbzRvSzFBcW9odlEybmVuMTJnRjUrS3ZIUEZT?=
 =?utf-8?B?dWlsNGNqZkJJWTdCakN6d080YVJEY3VlSk5JNzBxUWY5cW5MQmVMK2dwRThS?=
 =?utf-8?B?bll4N2JkSUIrdzFKWFY5UHp2MWlya01BNU9EVHRVdk5MWGtEdFJRd25CSXlY?=
 =?utf-8?B?Wi9aMmxsRlh6TnEwbFI2MzUrdldxZkNJQVVadVdqN0NaN2IvMmg5MFRoQjI3?=
 =?utf-8?B?RU1pcmFFNWpUTlhkU1JrRXJ3VHNlelo4ZEhJYVpZb1p3WEpuV0ZLVXhGWUVC?=
 =?utf-8?B?bTM1TVQwQllrMzkxODRDWkc0dVFsQ0JQMy85TXB4Z2JGdnovZmpDWmVUQ2lz?=
 =?utf-8?B?c0lHb2psbkxXeEVKSTljL09TTlZYUkFGZ1RaZjdFdDN6b2dTTDRqclFBcExM?=
 =?utf-8?B?SjBaL2dWdkZSUVFmNVBwbkFBSk9BM2FnNUhReS9PT0Rkd0JIYWpRdmZmOHNp?=
 =?utf-8?B?ZldNT0ZEak8xVVJoalNLQSsyNlNidkY1TjlvSEJZU1RHaUMrTXZYVG1CMDJP?=
 =?utf-8?B?SU9PYkhGbTMxL2t6M1VhWGZPTGFoMEdMRnJLSjdNdS9qVnVUenhLb0pmNjdX?=
 =?utf-8?B?dCsvVmViRldyQ1gzU0pKdEdDTis4Z2ZPSWlTVUw3MXY1NjdaTGNvbE9aeFBO?=
 =?utf-8?B?M1JQS0ZnNGRuOWFMd0VPZkVSakNuU1JraG9yZVArNmdBeTU5QnNCNXcvUCtK?=
 =?utf-8?B?c2pYS3Z5Z3dORjBuNW5ST0JhWmJPRTJUMWZPOTg2WTlzamlQc3JLWk1kYmt6?=
 =?utf-8?B?RkRMcU5kVjBrekZlRzJrSSt2UUkxMU1acCtzYUVjN1YwYkI2L1pFNXE4WlN2?=
 =?utf-8?B?VnYybWpkQng0VHlLRnhmQXBQZnZRWmJ6N0VJWFNvMXcyN21vckNqdjZkdWkv?=
 =?utf-8?B?OE1hTGZpSjlaUDZMSGpkaDFRSXJudW1zeVVZQXFiSlkyRmRnZ0QzK3d3SVVQ?=
 =?utf-8?B?aVF5WlZEanYyak0vb0dWemQ1b3lEWWNoOVpwYnFxVHdXMUw0UFB6T2h5dTFs?=
 =?utf-8?B?aVVWOVlmQWxLK2U2Y0dEMEFINWlRWmNFd0s4UjFKYWlNVUxMbHM1ZG5KUWth?=
 =?utf-8?B?aWpmYkFDNHhjWU5kN0NsaGVocXh4VDJoR2VPczVyWG9jV3kvSlh1Ykp2L2FD?=
 =?utf-8?B?aEZyL2p4VWp4ZFl2UktnSS9DdVZJYS9qT2VyZERGY1E4eVVjbzNBVEZqOHBF?=
 =?utf-8?B?ODNZQnVjWjlzVmxja1QwRFFZQzZhR2t4YmIwdlJvcEYrY2xLTENnUitOVnh3?=
 =?utf-8?B?RlZIWXVraUF1ME8vZkRncUZKUnpXamFnbG43WmRhdHVJc3hacEJpclZ6azhq?=
 =?utf-8?B?dkd3cjVHOTJxMHREZUFzclNWcDBLb3p0OTl4Z2krcjBxR3UvZDlQaXNQNU9z?=
 =?utf-8?B?SHR0N09scnJqR2hxVG9kclcvam9QbWhMNjM2L0RoRXFkd2JCWlpubmFnbU9v?=
 =?utf-8?B?akhjMzlidGZHZVNmdWlyWEFlTTdjRlBZMkQ1eE5yaEdUcG56bHptOWFhSXZO?=
 =?utf-8?B?NnFJMHg5WFpSZWZuM0F4WlFnOUFUSXFEOTJpSG1JdWNOcnl2UnVTREFib1VG?=
 =?utf-8?B?YjNvVkVVSmdVSVcrOG1XSXhJcDkrT1hxeUdiVmN5YjBtZm5ZZXBqbFpNcTQy?=
 =?utf-8?B?RitRUVZKYnRXdURRQXYyRG5mcjJDSWY3NnhMd0xJN0UxTnlDZGZBNHgzTW1U?=
 =?utf-8?B?MFlpU3V3eGdFMHNhWk1raE1XTDdsa1dGUDVOakFHeTlpdkRGcEgwV3lVZlVk?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C83AB3B5614FAC4EB75CC28E7C34BCA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pzIjFomzPvzEPuItAFJpmboXtbR8Vo55mNEShI4Fi76tqhNorPaFtbK5o0fv6EzZ0mqfsHuTp0C05R5ij/0mNY6FrrW+41VJQOi7Yo9ZdxXYwhWG9lBf92XJdTB9iYDMeF+juTQqbgG413GFAklKD/xGGnm9o++4kqq6JIf2P9Jg2Bb6nmON6m7TmuOd+CRIXCDr6iLHnnd6IWipK1P+litiLpjOi2sf2yvH1xzT4tb7G5Q20LuLFcT9/5x1P8S+olXZ80cLKy8qWwGnqzryJtflsu6zU+eWBehgJm3MD8zF4vyfDcWqm9dlkkd2hBGidS35i+44tp7r0gNi9Gxrfucr2ckignVgeVODT1aPuXYFHipakb0ZsUSbA6hjnfa8Em2QRgz958dojUYaO3DWuphUSblw6fvC86i7noA4AXxP1wVBb4P87Pkxk7pO9ulzfhz/BDFBin1DLt6ryPFyPog4AzuGWkS34eIxBBUKzzb3KD7P3guZVXuF38ZTjub2aYJZWPGWm+DL1aOGIgFcpMoojYGmpWwBCgq5mGSbnRt9dVRnCzXaXQrmHBkBshbarxZ4Rbc5jiuboF++iiCAqpErHdppodV6AfR+hcI8uPfaTznBcVmwM4/5KJ1DS8nzTaL54sPfn6ASUXqCWqpc6K30cWbqMf4t8DqNkS7BjcQktuRLcyCdqAGEIkFvMTc4AdCWBirtIokZJ15mmbcTf5gcl1SAsDtT2Yd78KF49yQrv4gM+93oWg5Vr5xuTVdcP9duBrisjcWE77eAar1JnXYPjT5pSvKX3vPzHS7c5wvi43diNLruCIOnslTDbst9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41fd1c-d854-4c81-0045-08db02955044
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 07:40:52.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTfS5I0J+4uXyUr5PEAG3R7FB6CVa3m8OG3Op47x5KaRspNbtwCwxSwdtyPVchRTP3kveJduHta5Yd6mCy4DS8vb/2/nS/9sDdsbPItC03A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4343
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjguMDEuMjMgMDk6MjMsIFF1IFdlbnJ1byB3cm90ZToNCj4gIA0KPiAtCQlpZiAoIXJiaW8t
PmJpb2MtPnRndGRldl9tYXBbc3RyaXBlXSkgew0KPiArCQkvKg0KPiArCQkgKiBGb3IgUkFJRDU2
LCB0aGVyZSBpcyBvbmx5IG9uZSBkZXZpY2UgY2FuIGJlIHJlcGxhY2VkLA0KDQpOaXQ6IG9uZSBk
ZXZpY2UgX3RoYXRfIGNhbiBiZSANCg0KPiAgCQlyZXQgPSByYmlvX2FkZF9pb19zZWN0b3IocmJp
bywgYmlvX2xpc3QsIHNlY3RvciwNCj4gLQkJCQkJIHJiaW8tPmJpb2MtPnRndGRldl9tYXBbc3Ry
aXBlXSwNCj4gKwkJCQkJIHJiaW8tPnJlYWxfc3RyaXBlcywNCj4gIAkJCQkJIHNlY3Rvcm5yLCBS
RVFfT1BfV1JJVEUpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJZ290byBlcnJvcjsNCj4gQEAgLTI1
MTgsNyArMjUzMywxMiBAQCBzdGF0aWMgaW50IGZpbmlzaF9wYXJpdHlfc2NydWIoc3RydWN0IGJ0
cmZzX3JhaWRfYmlvICpyYmlvLCBpbnQgbmVlZF9jaGVjaykNCj4gIAllbHNlDQo+ICAJCUJVRygp
Ow0KPiAgDQo+IC0JaWYgKGJpb2MtPm51bV90Z3RkZXZzICYmIGJpb2MtPnRndGRldl9tYXBbcmJp
by0+c2NydWJwXSkgew0KPiArCS8qDQo+ICsJICogUmVwbGFjZSBpcyBydW5uaW5nIGFuZCBvdXIg
UC9RIHN0cmlwZSBpcyBiZWluZyByZXBsYWNlLCB0aGVuDQoNCmJlaW5nIHJlcGxhY2VkLg0KDQo+
ICsJICogd2UgbmVlZCB0byBkdXBsaWNhdGVkIHRoZSBmaW5hbCB3cml0ZSB0byByZWFwbGNlIHRh
cmdldC4NCg0Kcy9yZWFwbGNlL3JlcGxhY2UvDQoNCj4gQEAgLTI2MjAsMTMgKzI2NDAsMjEgQEAg
c3RhdGljIGludCBmaW5pc2hfcGFyaXR5X3NjcnViKHN0cnVjdCBidHJmc19yYWlkX2JpbyAqcmJp
bywgaW50IG5lZWRfY2hlY2spDQo+ICAJaWYgKCFpc19yZXBsYWNlKQ0KPiAgCQlnb3RvIHN1Ym1p
dF93cml0ZTsNCj4gIA0KPiArCS8qDQo+ICsJICogUmVwbGFjZSBpcyBydW5uaW5nIGFuZCBvdXIg
cGFyaXR5IHN0cmlwZSBuZWVkcyB0byBiZSBkdXBsaWNhdGVkDQo+ICsJICogdG8gdGFyZ2V0IGRl
dmljZS4NCg0KdG8gX3RoZV8gdGFyZ2V0IGRldmljZS4NCg0KPiArCSAqIENoZWNrcyB3ZSBoYXZl
IHZhbGlkIHNvdXJjZSBzdHJpcGUgbnVtYmVyIGluIHRoZSBmaXJzdCBzbG90LA0KPiArCSAqIGFu
ZCB0aGUgc2Vjb25kIHNsb3QgaXMgdW51c2VkLg0KPiArCSAqLw0KPiArCUFTU0VSVChyYmlvLT5i
aW9jLT5yZXBsYWNlX3N0cmlwZV9zcmNbMF0gPj0gMCk7DQoNCj4gQEAgLTYxODMsOTMgKzYxODEs
NzcgQEAgc3RhdGljIHZvaWQgaGFuZGxlX29wc19vbl9kZXZfcmVwbGFjZShlbnVtIGJ0cmZzX21h
cF9vcCBvcCwNCj4gIAkJCQkgICAgICBpbnQgKm51bV9zdHJpcGVzX3JldCwgaW50ICptYXhfZXJy
b3JzX3JldCkNCj4gIHsNCj4gIAl1NjQgc3JjZGV2X2RldmlkID0gZGV2X3JlcGxhY2UtPnNyY2Rl
di0+ZGV2aWQ7DQo+IC0JaW50IHRndGRldl9pbmRleGVzID0gMDsNCj4gKwkvKg0KPiArCSAqIEF0
IHRoaXMgc3RhZ2UsIG51bV9zdHJpcGVzIGlzIHN0aWxsIHRoZSByZWFsIG51bWJlciBvZiBzdHJp
cGVzLA0KPiArCSAqIGV4Y2x1ZGluZyB0aGUgZHVwbGljYXRlZCBzdHJpcGVzLg0KPiArCSAqLw0K
PiAgCWludCBudW1fc3RyaXBlcyA9ICpudW1fc3RyaXBlc19yZXQ7DQo+ICsJaW50IG5yX2V4dHJh
X3N0cmlwZXMgPSAwOw0KPiAgCWludCBtYXhfZXJyb3JzID0gKm1heF9lcnJvcnNfcmV0Ow0KPiAg
CWludCBpOw0KPiAgDQo+IC0JaWYgKG9wID09IEJUUkZTX01BUF9XUklURSkgew0KPiAtCQlpbnQg
aW5kZXhfd2hlcmVfdG9fYWRkOw0KPiArCS8qDQo+ICsJICogQSBibG9jayBncm91cCB3aGljaCBo
YXZlICJ0b19jb3B5IiBzZXQgd2lsbCBldmVudHVhbGx5DQpzL2hhdmUvaGFzLw0KDQo+ICsJICog
Y29waWVkIGJ5IGRldi1yZXBsYWNlIHByb2Nlc3MuIFdlIGNhbiBhdm9pZCBjbG9uaW5nIElPIGhl
cmUuDQoNCmJlIGNvcGllZCBieSB0aGUgZGV2LXJlcGxhY2UgcHJvY2Vzcy4NCg0KPiArCSAqLw0K
PiArCWlmIChpc19ibG9ja19ncm91cF90b19jb3B5KGRldl9yZXBsYWNlLT5zcmNkZXYtPmZzX2lu
Zm8sIGxvZ2ljYWwpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKg0KPiArCSAqIGR1cGxpY2F0
ZSB0aGUgd3JpdGUgb3BlcmF0aW9ucyB3aGlsZSB0aGUgZGV2IHJlcGxhY2UNCg0KRHVwbGljYXRl
DQoNCj4gKwkgKiBwcm9jZWR1cmUgaXMgcnVubmluZy4gU2luY2UgdGhlIGNvcHlpbmcgb2YgdGhl
IG9sZCBkaXNrIHRvDQoNCg==
