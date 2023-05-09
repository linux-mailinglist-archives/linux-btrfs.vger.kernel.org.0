Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E58D6FD090
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 23:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEIVLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIVLB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 17:11:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92949138
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683666660; x=1715202660;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Py88/U/tEBJfAc27B/KV4c2OWlCi36hWGr/HySZuD+kJamfZEFGoY2c0
   q8r5yRBM3A8u/waNJCHDZay/InsRdMKH8ykCO0kp/n3DOeqhtGZc4/ilP
   p0iFSfZXcBGdZrrSbCJDHCxki0OBjSPRFVCS0p28nlifehRGfVo051vMj
   ip/QhcgboI5lrpTpA9AIV83JQaXOBb+YmrRtoWh546kisc/k3zMwZ2Ld+
   NaVGTcI/up4rZIpWEshkjV3SBBVNfvoUOq1CBEy/84mVb0YNSgl7E0Cv+
   wPcHtdMHozYUFYSTLimYeLI3nTjnNXC4fC1JPbspFrodNEAfvyBIe8GYD
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="228470328"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 05:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdqQqL28o9Zm2owc1OuT8qSEcr926xgZILBwYrnSjKbI0YqoeJgzqgcGUEgK8DXZ8naoBClklK/YEFWl7SvCHGyhF0qGDsS7A84SMghHL3DPMntXD3qlmHAgZCDpWEEw5xHElH2ePLv+ok7bUwMEI05PUKEvAFES5peMasbWnTfVNxyi4M/Byt2sUD0AxDp5qs9Lp7nkDaKGVcJ1ZbFMiklQ1BrsbJul4rlsR5Bjfpfv+EUov4gSRXhWeUtjVjtLyn74Ab6R/zbMkqkepWHZt9eQFj9UDyImSjtU69krwaaryIU9CSiOm0QCmaIdUzKDhLlmmGExK99Hc2EnEY3MDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BXz1/zRAo+RcLOV/qKhgghz8G+rtJ5laIWWhQTrehb+wKczgcBLMhybXX3H1VUbdtOk1aNTuiSh398Vjug2/QhpM0gwP2gKyCxbbI3uKvbjQwMuFkkfaRfu2Jrb0Dt3s24kWvFNcDcT/6Am1LgJykBM8l0KUdIfXCMklKPnbA9AV1SwAePzuqAOnA1paNKrv616qFWyQtx0sv9GPk1BHbWWrI9ZVjZwUmeCRAGDScochfeJvu1dvA2w2yXSCmbhPw3S6ZMN7ePh+LasC2bYURqcluTqN4K5HlTGY6AsJuz3forROxnvbLxmgYQQJRS6StnqturinZvwGP9YIeTVTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AgVcZLYC31TCc+tv8YA3wjBrLPPy8hKMXRyOk+kmndIwNgSXWocRVrb60KxhocCQJ/VWpcYNTbsuB9dLVZ05MRNUNfau8tOK1fG6y701tV1g1ExDnSjFoD4o7GcbvN9JVxPJmQWD7B7nP97PSCpR54RaeqvaskMLBWoqVqzPee8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8026.namprd04.prod.outlook.com (2603:10b6:208:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 21:10:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 21:10:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix full zone SB reading on ZNS
Thread-Topic: [PATCH] btrfs: zoned: fix full zone SB reading on ZNS
Thread-Index: AQHZgqQoUX9kurJh40mMgmNliEZiNa9ScCyA
Date:   Tue, 9 May 2023 21:10:50 +0000
Message-ID: <cb2c8d58-ae11-b7a8-672d-576b9cb50cfa@wdc.com>
References: <1932c39db3905ca491009e9956afe511d7b4767c.1683656399.git.naohiro.aota@wdc.com>
In-Reply-To: <1932c39db3905ca491009e9956afe511d7b4767c.1683656399.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8026:EE_
x-ms-office365-filtering-correlation-id: 4b15cdd1-2286-4766-0c51-08db50d1dddf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MH4bor0Qpj2gr2oLC8yVT019ODcXOOapIDAeIJp/v/Yx158Y5v9sDfCB3fi2hq/H0oRGt2qtVYRNk5lz1KhwLzhNyVd3vuxB5UQuLnd+p5dhuck4Y92s1dYnumOIZM2mA66xDDw0qhv2kjCX1PrMSmYA07ugt1TPySaDw99y807LnPkDxpqNZYUKNuQ0BC94c2I6Vo+rXeIz4ghHRJf7YVt8Sd5yO0HrVHmPwR9jUXbBpizmRMr6ejvi6kt1/U37jCYHC9EyRJVcFElQQZkj0tSYr8ipb6l90EH9CXf+E+4TGsjdk+wPfQk+PIdgX1uNilQcsDrvOJBHTdvY/40mIAfIYjzb0zDlaDfusOBooJEfGETW38hlrDKUty1uu/mwZPUnT14VO0bz7P9hwxFrttD8tSZViM8YGz5qpnW2brG1WgFdqMUjyM4slV/cYx3RBByd54lWfDiPlfQ6eO0JBM/vba0DaPPv7M8JkcqpOL94zzdWJwjJLiO+39HqzvdX/HeZ0v34exEYKcpZx5c2whdlYyM+yLtZD6rXfKLaz/0yuKytiAyyug9XYbD+8O1X8biiWjBH3fodHNPFLUf0C9b44hmbacKEGYiPSqPr8EvrDVJcELg78jEZ4FjBimlB1429Gr4vAgOEA9p09XzJUWbCpGWQedRBzSRRVO4SZ3qbKL47XiFUa5BW/paKKECz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(6486002)(6512007)(26005)(6506007)(36756003)(38070700005)(2616005)(38100700002)(31696002)(122000001)(86362001)(558084003)(82960400001)(186003)(4270600006)(110136005)(2906002)(66446008)(5660300002)(31686004)(64756008)(8676002)(316002)(8936002)(41300700001)(66476007)(478600001)(91956017)(66556008)(76116006)(66946007)(19618925003)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlAycXRLcHdrWmtBK1pkZkRnTUdReFM3TnY4SGkwdGxXOGc0dHQzbFlnaXdv?=
 =?utf-8?B?ZGpwYmV2dXVycVg1QmQ4aW9HWkwvbkpWY2hMQVhmbEZHa2pqaFpSRHFmdGlC?=
 =?utf-8?B?T1E0Y0NVbzdUZmcwdFhYWGFkUDZoL3JZMnpJRXY5eW9pbkQ3SjVpQ0s3MFFW?=
 =?utf-8?B?VUhJVmV4OGtHZzNBb1RlTEFLY2tpbFBlVTYrVUJZajhuYlE4Sm9RaGtOZUc1?=
 =?utf-8?B?VzMxNTFDazRBVDd2VTRnRk1kVDB6ZGY2VUszMm1zWW55a0YxeGtiQ0FjdjE0?=
 =?utf-8?B?TjNMTWpTQVNqRG9lWVNqeUJWSjlDY2N3cnlNZEtFVXQvK1BhNGp1eDA1RmNK?=
 =?utf-8?B?cmh1OTA1TjRFbDhpUTB5NUZjSWNEdkV0bU1hYjQrVWxUQUFaRnZTZTIvbk9h?=
 =?utf-8?B?RkZkeSt3cTFUSUFwNW5ReHg2ZC92T1pRQ3JlQzJxbU1XY2JsRG5QR0FZV1Rk?=
 =?utf-8?B?dnlnUE84Z2VMLzVDeDhXN1ljN0JNUi9vWXdtMzJ0T1JQZ0drYXMxZEpoZUxq?=
 =?utf-8?B?L3d3d0pzdVhrWmY4QkJ0S3Fic2lQcVVLZ1h2UmFpd3lKZlB5NS82cTZ1cDhu?=
 =?utf-8?B?cUZOL1A3eWtIYUNWdmEwS2lGUGxhUGtURy9vZ1IxNUFZdy9iNzkvc3ltVHpD?=
 =?utf-8?B?ckpvakhMa2huWEt5ZmJzMWJSYXBFanp5bmRWYW9oZFllQVd5TGFlVjV4SjV2?=
 =?utf-8?B?eGQ2M3ErTUtlWUtMcld5Y3Q3cTdNM0J2NlZmZXhXZHJNR0FCUmdtcVAvdk5u?=
 =?utf-8?B?Ukxmc05ZVVVwa1FtcGxad2dZTEhkeDNIY0pzK2JWczBIZDBzSWdEMXllTFRp?=
 =?utf-8?B?Szc4akROWGN2SDBub2dSczlvSEZWSlFxNnBtM3pmckxPVXBTYm1LdmVpQjBh?=
 =?utf-8?B?Njdmbmtla3NNaW9uc1BneGhkelV6VHJqc0Q3czViRXpUaWhiejc4Vlc5NjdW?=
 =?utf-8?B?NGNzNzcxNDZMMkRtZ0Nhb3dISmJ4NTRuaG1uS1A1SDhORW9GVEUxeUwrTWdI?=
 =?utf-8?B?YXFvcy8ralpkUnYydUZJbG5GWEpwTTNJM2pkL3BoZ2xWQXlESkpoaEl4Z3I0?=
 =?utf-8?B?azFDVmJBL2ZUNDVVU1dXMzkrUURSZ0FTUzVLanlhVXpjNDNreDRRSXI3L3Ns?=
 =?utf-8?B?aWxtcmZ0M2habWFqbVRPaDUvdEFlZWZVWFJxSGEwTC9xQTdYb25xUGsrdlpP?=
 =?utf-8?B?RDRIcG43VW03UnF6SHFyNy9sZm9xemhxQjQ3YXZwVGp1QlU2WEhOMnZ6djFZ?=
 =?utf-8?B?cVRzQVpTTjhtTEtsQWVPQzBBbDhGR25FaEtyWFV2MzdWcjBqM0wwakgydGJn?=
 =?utf-8?B?MEFLQ2xmTndBemEvNEhXbDVoVHZPcW1GdlFuT09nb0RXU1RPNlFCcWthMUs0?=
 =?utf-8?B?VUZWYmJzbTNKSy9hMTdqbUt2a0J2dWtPTTRwc1g0MDBWMTVJYkdFWklVbTF2?=
 =?utf-8?B?UkdkQmxEbjdVZXVIWWJtVGRiSHZ0YXlRY2ZWYm1oZnA5WHZPTEpwRGNmRnFU?=
 =?utf-8?B?MnVnTEdCbGU4N21wdC9MVEg4REpEWXFpcitrRXUraGdPNkxwTkVZeFQ3WUVP?=
 =?utf-8?B?SVpBMktCcS9rUzBNZE5XUWNNSURhWHhob3k5cGFVTmxLaGZ4NmZockNMazBV?=
 =?utf-8?B?ODYvV2QvcjBsL2hhVnFwODE4MjAyb3hxUnNZT1VkL0ErYTVOekkxU21PVkh4?=
 =?utf-8?B?aGhjZHhGM0dtREJJV2g2S3BET2o2NXgxeVRKSEdscjNKTUp2clo5LzVoVW1L?=
 =?utf-8?B?bHp0VGlzbHQrL1pETjBnQUJZNDRmUjltZTRCekFlSjhCdmNwYlVhL2ZxK0pJ?=
 =?utf-8?B?aW5Jc1VzRnViMmFEQ0pGdHBIRVdoUU1qdnpFVXRRbkFJVXE0cnZWc3M0TFlq?=
 =?utf-8?B?TVhBK0YwSGhIeU5STXZ3cHFvaVpHTEVhQ3M3a09WUkJsckJZVHYxK255MVdF?=
 =?utf-8?B?dlptR0JKeitkeVVmRENRNHB6RWI4YUpRWlBQeDVMbTJIemR3YkNUL1VPUmww?=
 =?utf-8?B?T1IwUUJZcyszTXJDVTBQNFd3Q1dMeGZBQ0VUbjlCSkkzYkZCY0Y3Q01lSWcz?=
 =?utf-8?B?OVR4L1MwR1hOZGdKUVpobWpUZ1I5VEFjc1cxRWx0aXM5YUlmbDMvZVZZK2FK?=
 =?utf-8?B?ZWxDSEtKcmluNmxZRzZxcWFvMXA0OW9ZVEdGNDh4bDhFRm1OUlNNUmxrbHJS?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724036FB07C8B448B8D18C9BC915CE2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hwIYGlNLlW6rmomATCU8AgSjTppipu7Vhvibrda+kqvVEiKrwO2Z+4nM4zmq2Tl24CUeUwEd57jLU/UUVcrtJD3Lmg+ImoNT5PY2Be5crUM+H3gQN/rGdAkjDQs3XW50C7nhE5aFodo/+mu9JkiOfvyTh/IuVFnwiWyMlxA2b1QAXTGYESWKSfc5e+r5G57Y1dOBlcpo+3Nz15Tuv8J4i1HUawmqe+BN5mPAbpCU+wfBeRYSLmI347Y71WHuLQd55DG9IFIOWNIJtt2YhRKwUyz4vj10UZfI+dUpb4UNj10XoO20Ov0+OuFKDkKAWbzDOJ4agGCUu+WTd2JHg1eSEYGssJH37joRkISVsLZ61ohUuhfclfpKLsovcd942s+UL95E5Y9u624dFKGIyi94chhQiqwPvnB/L0SQwTJooKWBL46ZgkwDSd2lax6MW8JqsLxiH3a+d4iUweKtLnQmebgbxmzLh32Ot/DFYCRJUCBo3dAEtxPXnUdQWcJ02dC3JQlkPRPuH1dU1KfD2akX2ddfRn1o/zk5sRh+cJ9UVXkqF+ty+nVLmK3kfMlzqQHrjuHDWBsTIkM/cdJi8pPvZ4wt+SyMslYBOcsOn+qst3wlE/HrRxbXMRgSoMPSRtio5KbzYq5eSBdg+nFvkuPYii2pBMk9OnZyj27Dbhj3URz4grU86aSydm+WQgEfbDoVUHpzfwT7kqOr+6K6T/z2yH7J525UnzaQzj29u89NNXA34eglqNS5x7LKZ19/dKJ4EzifiWS0BftYjCzKrPOcPg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b15cdd1-2286-4766-0c51-08db50d1dddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 21:10:50.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwlevz8F9zG4Z5dtZV+WTOeCwcPr6lyiC8Cr8Si9cd1mC/sEirzItgvmHU9UGrvA27V67HCynB+vMVcqpzHsk/lvmR/aTlG5t0V/6cC+138=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8026
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
