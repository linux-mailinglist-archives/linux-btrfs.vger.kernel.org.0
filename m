Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32D6B24C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCINAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCIM7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 07:59:40 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728C2E6FC7
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678366710; x=1709902710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZW1uMbZQ9wlre88uVyB36VAC+fs8facDxV/ZLsjE4DLO4bTB7KjxWqr5
   5LXeW0IMb3l749bJKBSQNov1D5Iyiq++YwbWAcTHr/1gD7BnLMfNHQNch
   6+6T1K3OqUdftKQbqmw4GPCy8LJ9Q4XVMxNkA7Sold88yA/VrMneNyVGN
   pkeQqDS358IJdEcLc/iHgBZKnpX0eES1mUrWCRLYFUvW5q+/MfaLBeJJr
   ZOZkGCPv5/N2OVR8wTGkutS7mj3AXEC7JoKLPu3R9UC5T7bBgEIwBWmb2
   w7X/O7h654RcOx1/zMZoixa4uOHNqVGooJlkwhwqGZksUyKJGLuXuxTIc
   g==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="223515779"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 20:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+TTV21utxCIwDdmd7lhYGL1i9EMVBjSG1HKQhXaFsxw0nFOuysOCY0CI4MgEW4E4cduZZUJx+iR+Jm6uuLJZHZxZGIrI68MSB006qOIOLJkNu5xkj2pghCGBcC5DGBy0ahygj+gVL0LVTnfDbYhNmEko91q2ks6/IAtR2QNFafvkzMKwlPA4Yzv2cEe31HDSH7EkjgMBbv2hoLSNCi2G9iYNuH2+o86XsSqFcvYDRu99cV7aaOTFZ3IMOC1SX7N3mWA3bqkjtyCalBuh1ZIj2QNIecvX7By5xh3D1v9zrM+QzbVZUnGVXlaQm+oYFsE191fGmxsHh9dY/QCsYXI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=I5rVZcCzpslrXPKXhl6tpoGLsArxMhADqXrU86Vfg0MhP4duca61iTj4dNlj0H11Ppik0Q+2FZYUpsExW2RASPtzQnn/gV9lgKvzFD2X/zLSdinMalZfaMJ8Xdmxvqnz2Pi/GGHg7gzAxFwCEwa0fnFQhqFcXwsnR+g8NuKClSlgx1DEXwMKyyen1DRQrGDSMt0CGaZfj41We8iQ/TKc4THlDZONfJqWF/8Y2jR3D/N56bWmnJBPBDCuJoX+I8UzBBidXON3Q5xXz9lBA+nVd79L05bdV82DcrvQBhcRRNzpPFuPw5v0ZNMTsp6XusOpMDjSRrbDkRsSwi+gaYy50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fc0BYa3Et5xeiZn46skka3Ry9sqJXCFdQlaqwOwn71Ib96oXWlweOhJTAjapAOp3ydgr5mnuIuEaWlkTgtyZ5C2cWv59b1QobgvBA5Dqbf642kyCPoxUqGt4oWd9j/fZEX8vTS2F/TDiRbd1COpnIaXAtGuly/dZd0pJZ1uc21o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0785.namprd04.prod.outlook.com (2603:10b6:300:f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 12:58:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:58:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/20] btrfs: remove the mirror_num argument to
 btrfs_submit_compressed_read
Thread-Topic: [PATCH 06/20] btrfs: remove the mirror_num argument to
 btrfs_submit_compressed_read
Thread-Index: AQHZUmaU5GghvySHzE+bmVgxdkU3La7yaMMA
Date:   Thu, 9 Mar 2023 12:58:03 +0000
Message-ID: <3aa08bff-3eef-3ea5-23eb-842786df2d7b@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-7-hch@lst.de>
In-Reply-To: <20230309090526.332550-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0785:EE_
x-ms-office365-filtering-correlation-id: e4d7b8f9-2e5c-4b7a-3c92-08db209deb5a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: er76cME89hB59Kr+aFMMV7LnKpgRGUhnwJxkdYgazKKIpH4pPd3f1pmc5fod2mtPC8eJjp68yv2gZ4+svBgw1XwnlGnC2s5IiX/kym3Kv/sNch2nrU4UPvPlcq7PcMbk5ub2d19hPy4WKfOYiNhqWcrSMz3BrbWbIKVo1ywqDdc9jiuOk2kbQCLjYMrQ7IZLThijQU24TXA5XToq6a978gqg3diR4HnjW8abdzhe2bZ16m/dSbvsuPbqIvAbK91IENeYFssLACDGkjiGeOAQIaZHUHruYkAbeS11mh0u8aB6JXJfvBf0AI6wlnxaMZD4VCHVas/+krY0m1HL3+ngqnlD9udR36eUE6W0xs7gVoJKEcprfozGcLJOeJaxUV8IefiAPa1c/5Yb/U4PPBN1urrhyOz8iXqoPPcJQ/va3fHEKGyjvcT/EpRd9nULUWJA6iRsxvPA64OXcIuLsGKySnXZxnSAxNQqh+ZDIsU7jhToJU2gqkqaJri56WZ1/fzs3Pc9tovzt9gySsDiz4K0TzqDSkAhNqVWYXT59tZdy1BOo5RSJ15X7IOnQrnZ/c0JokDzICeTWausnasrVrGNLTXheRZmhcTL0Vq6tKuzlBU/9dfsupL4TJ1DudZZQjmfV45QKRzB8meLsceLH3NYWQwf5dLHyA0G3HFkdnh0dzGT5K83kYmMPEckuVi6HYB09tLPc9f2+GWpdzwQTSc513ebn1zawYsVx2zZHz3BCghuS2Bp052n52PisMZyswBC6rp0Sd0QdQUCN5AOou+5qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(19618925003)(478600001)(2906002)(122000001)(31686004)(38100700002)(38070700005)(186003)(2616005)(5660300002)(8936002)(82960400001)(26005)(6506007)(6512007)(66446008)(66946007)(66556008)(31696002)(4270600006)(91956017)(76116006)(66476007)(41300700001)(86362001)(64756008)(110136005)(316002)(558084003)(8676002)(4326008)(36756003)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGFRUlQ3ejQvZ2JnTWp1T0U5d1F4Mzdkc0tsT0dtZFN4b2YrVnN4ZGFnV0c2?=
 =?utf-8?B?enZuc0wrZmVPUG5iOENPSk1sTks1WGhXR04zTm14OUVZYUs2Z2Y3cTB1R3Js?=
 =?utf-8?B?cFIzTll4cjBNMmNMZ0hpNmJVVmViNjIwa3l2VmhRTXpVclB0WUNXM29YRkJ2?=
 =?utf-8?B?cVp2RWNnS3dmY2pyeUNmQ0hkeFZlV2FxNkNHelpEU2RnTnd0UFVsQnFNVHVD?=
 =?utf-8?B?WEhlZGlybUxlVW1QdEhuMkM0SVdVRmxjTzBPQkdsS2pmSC9VSys0T3ltZjE5?=
 =?utf-8?B?eVpEKzYxSkJVT2VLVzF1Y01LbE11UEtSS3lpNURPSEtHeHg1c2pMdmE5UWVK?=
 =?utf-8?B?Wmd2TkVBaW1QK1FadzVxT3VxYTlDNWc4VkYwWURUVStXTlVDNk9uRDlPVis4?=
 =?utf-8?B?SUxoaTlyVHU1NDhZdU1VSUNlcGRFbzQzVzRwQjlmZktXT21vcjVDSWhScTBa?=
 =?utf-8?B?N1JNdTVuRHM3K1ZqcWo0aWZTQTZKN054QTM2VHdkTHl6ZEdzWVd5WmZ0Qkkx?=
 =?utf-8?B?bzgwNjhFU0U2czVqRkg0S2k4YjFubE5VakRBZmRxb0V4aDdEbjFpQThtSVU4?=
 =?utf-8?B?RVoxREZNNi9pRkU1dVpjZUhUK1NIay91M3BSZm5tRWRCRkhRejRCS1hmSHd2?=
 =?utf-8?B?OExDYjZJVUtxRm9IQ0EzTUdYMHdCY0I3ZnZpMVhLQWQ3U1hqSFptVnpGTXM1?=
 =?utf-8?B?ZW4wWmdaV01sY0lJbVpHdUxGMm1wdlRUWmJrVWZxb1dzMDlNTnlpVklESU5Q?=
 =?utf-8?B?V09zVVQ5MnNqeDdRdXJzMUNldE4yVkMvbUdzOXBIUHpISzRGOVlTOXhYaWM3?=
 =?utf-8?B?VmtTUm81T3ZQcW8yNE1MMVdrNmpPTkZNMmIyRHpxclpZVUNDekU1c2VDbDlG?=
 =?utf-8?B?NEZHL3ovWUZzV1g1UUVjYjl2d2x6OGp2aVZkdnBqRStWNmpncEkzLy9RbjhF?=
 =?utf-8?B?T3pLck5uTVNoMG1BVzZQanYrMzVPWnZMQlBMaGcxUlhsZFYvVWNUQy9YQnVD?=
 =?utf-8?B?T0hiRFh1ZHdLY3VtVzJqaVg0ODNiZzF3OU1UV2p5ejlHV1BUK0NRODd6MERO?=
 =?utf-8?B?dG1rNFFPK1NvZ0poU3BZL0JySk9kSmx0QndmdEI4aVBDc293Vk9MdDBWZ0NF?=
 =?utf-8?B?K29MbTRKMUVaMm5PeWRUVkdMV2hpU3hvWm0reDFGdzQwRVRZRFRoUWhqNGo5?=
 =?utf-8?B?cktmOXVFNnJUYjJiRFNBb3d5WUgzMHRNMzgrcmE4NEk2RXpUVldRQzBaa3VD?=
 =?utf-8?B?TE0xRXVKeC96cG5qVlA3YTQxTWcva3dHNlVSQU9LTEsyZTE2SjlQbHNqSGZv?=
 =?utf-8?B?T2JudHNHTWUzSFNsc2E5LzBab25vcERwT21ldXQzblpEMEE2dy9nTCt0ckc1?=
 =?utf-8?B?TnZaQldJU25TZkQxRDNrL3JoTjB6dEgzM2lSOS96YUlCYS8rRmdCenZLdWNv?=
 =?utf-8?B?VlREUlE5ZUhWV24xTmd5Z01GaE9LMEdrWmpDTEpMdThuMXRjYVpKUmpTVjdj?=
 =?utf-8?B?WG82cmxYQk44bUlkcWhPSi9QYTdRZjlpS3BqcHBwY2k2S21qK2E1dzVVTWJt?=
 =?utf-8?B?M3BDcG9YbytreXZJOGluTUxRaE1BQmVaWG1pRjdzYTNkcHFNN3RBMWhGeUJH?=
 =?utf-8?B?eExuRWdON2d6eXVmcnh6WElKUTI0ZnFEdmNyZ09yNDVkeTNQZ1F5dVc5RTlV?=
 =?utf-8?B?WUZvZHB0TEdLSlU2ckFGbHQ0QWdqOTVZV2Jsc0F0aFpRakFnQ0IvbHRaMWlG?=
 =?utf-8?B?clBNUXp2b210MDlKdDVRM1dQQWl2S1NOeU8xL3BpZ2pkakJ2YXlvVkZVQ2pm?=
 =?utf-8?B?QW1qb1JhVFZXS3Q2aWZQMEI2NkZIcU1iNlZIeEU4Z0RoWVVDN1dsbEtOOXBV?=
 =?utf-8?B?RFQxemsxcVYvaHIybGpobEhtekhyMjlUZ3dYMnVKSEU4cHY5UVl0bVJ3UE1p?=
 =?utf-8?B?bXI1TWZ3SFJMejJQVTcrcmp0V3ZGUWw3VG1MMENvYTRSeHdyLzlBam54dnBY?=
 =?utf-8?B?QnNhdWFJZW1JRysxY3FFSjZOOGJ6ZVJQWWZvL1lnUEVIM28wQW5ndFduRkdm?=
 =?utf-8?B?ZExSU2wwbVo5cU1aOTNvalFwNTRXUkxMZWFkTmR6L1I1U0lkK1ZiazUvTXJQ?=
 =?utf-8?B?Y21nVkVjS05YbUN0R3dHUExFemNVUTd6QjV4NXJlenp1RkxzRkNCU05HRGJa?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2181F9EF38EA74D8342D01771E72095@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hETXklrV4iwoutlsBhzLRCEfTT/oURUPGa+nc8fJXQrIkrl+YmdKRSpzLUMTio+kCj8JZxV6zUxPkTY+LTrrR+Y7BBHJUb0/q9j5BdPXAEufvm2GaQ93bvOjrNxaT3xzcI+NYCnGsRnvRTlAwtN2V/sR6gy3x0hLxYUxOLBrux0b4JZcy0kX60hBbBJC6IzPOL2MtMA6ynOZeGPor+ueghTy2rQeE9yads0EQd/2YE9rdN1fS+ZnXnKDUlUO41AW9k871mlfg/mlx+Y1xv8gTluUzYScRXj1to8yqjwzD9xwRn3fquettUWmJDWYn85R9V5hc07FcB7Az5LsnCMc0Qcnl/OrI/U+li188b0Hk5fZJWzl4yj4yl4AMIBL1o1anIg+h/FJaqVsK1tgkmEV/2P5GKWtSmFTQPSC0SbzHvW4cvUdvhA9D1Sbv+weukWJWQbXp1p7HpmBrP3ezT1Mh3W/OEFjq0oIoE0ztTbDUX4QwI8W5yA5tgpz6Ly+Z7yatj+figHpc5yxFY8UE3WGiDVr1G+3LHNPNxlvb41fYzRKigJHd/Vj6BGlPSvI8ui0+EP+xm6dtTe51VMYk6qJ0bcUJ6VUta8R01H5NQSDr/qlmfPiIk1Ns7C6wy12V7aSDaeqM9VCqSzZ39G4fFXk91QQIIb737AE1zmvf3hNDnVSqKOJRccie4epeWiq4BNHG5G+BfOm9MqVQiQ61QRsj8R9khtA7dkNWHhdFs0eCctZvPb3NJVxWPCufwF2ytUlhT4Gi7iQFSGMsW+7fdCFu/rohKq//HMe4rc0DCI0/yPSmdr6IPf5Q30nIhqH6CCrcrxteCa6Wj7GqHsRerCZLDkV8Nm9VIxNlFvnyNFJCQc44PzOtaTvYVgWhR1Y4sNQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d7b8f9-2e5c-4b7a-3c92-08db209deb5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 12:58:03.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSdeijV1yMrbQkGV8nEulWqtj/75G1S7WhbpoNVLUgLFHHjvmuL1b9U1LQToAOAnstBGOPT39Sn9SSQTcL0Jwjaq+I4+TrTIGfnIhE3WhQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0785
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
