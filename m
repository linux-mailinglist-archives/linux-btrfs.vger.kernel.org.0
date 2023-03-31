Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A546D198D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCaINz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCaINy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 04:13:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709881B7F6
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680250416; x=1711786416;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=oPrDWdJHMuqnE/56A3o3/Sj4rHlE4NsvvtMhGzaTF41KL81v6ItQEG91
   krkjHvTGfWlXDsg/Vs05ouxHI/R7sJKIeRizGrzbl+KpVbCFj9Anrur9y
   SirhPN9ZCc7EHgT77cMRpIlRVJ26ASa0G2tI6GYxnriNOX3P4xd6JopPC
   b04iqs2QITznOWeRVdinZNRHunvMHsnct7mSoBIwkpc6GAL9wdCG+rWpx
   51OFjEwwby2GQoywjsr+F3bMvkE4tE2SV9KRzT5KAgqgwDqaZIwkpJdJL
   uKo3OvWiaiQfwxf42QdROAhZ+mSuKgWR1X0NRcEzXekoL8sPhTMpEIWpm
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="331408140"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 16:13:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcYZH8igjWM4pJ35MwAz69+0dVXVEep4Yl4xGl8lfQERUq+mVr3IjZzvnonWjEPmvzmkAvZrKL5H4TjoWGZWxHxFiMo3/nKRV23f9PL1HXqwlGIkxleP4UDNkFu9G5NlK5ocLKCsXC7U1b2jsOnxsXLJ7ODqozB7Q+7HIWkdlwXuBB/lIaFSR7ZfD7e/AK5/gx1j3kPtycSt9+EHbiK8qkqfU6vxEwA48KiOP+fSCiTVkp7u4cwLuGNP+Cs2kxPKhOfPY8jsJ5vO88le4I/jkRlAeTngVFRZ+IbKSEyjiYnPlWC6M6YUKObr/fjdGLgDpGdfFawEz47XA+6kaQ6qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Y0x7ubzcUO2x9Ku29bafhybdEKfrTFyPCMcF+RFsUghtcEivnvgITAYRX9CDiaH8Ax1QE8FMfApMY2T71CCWJKm2ZFD3vQ8gySLoE9RZXnIqkpFE+G529Fngzs+FIL8z5KVFkVR1o0G6gqzgcshGCkaMITFRZqEz/EHKFwrDdjAEe2/ZyxqiCkipBzTq19z5SO0vjObrjKFcW0gf/QKPE1J4lGvHvUl3j/iqPUV2ZHPzdJMdHLJ/LiPUQtZpSc/ig8x8BLxs/Dx7u0pHfkXkvtEnlMwiPFFRUBwRgZA48Nz6bRgo5bcShKseLz6VZuSSGao6dg/+fBE//VPx3Oy62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Sz4SAvHLBYGg9BsHmHtnv1dJxbVHHHe620qfkOMokxTSnJnR5njixmj2cbPuGDsYK770MXpk3dPi8BN/jwWXcxOl26mBFEVc5rdM0GaXpDc78xKla9k635VRIBLYeV9E1kl1gvHTzUVEWv9Gp8rw/9sWFg1SRy612iDhAilqhVY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6475.namprd04.prod.outlook.com (2603:10b6:5:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 08:13:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%6]) with mapi id 15.20.6254.020; Fri, 31 Mar 2023
 08:13:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v8 02/12] btrfs: introduce btrfs_bio::fs_info member
Thread-Topic: [PATCH v8 02/12] btrfs: introduce btrfs_bio::fs_info member
Thread-Index: AQHZY28FHnKSwgeglEmjOyLKM5jE1q8UimiA
Date:   Fri, 31 Mar 2023 08:13:13 +0000
Message-ID: <64af0745-2041-9dcb-7a4c-ca0f7ebd0ea8@wdc.com>
References: <cover.1680225140.git.wqu@suse.com>
 <9a96394d97db24ad695b7f89f2d28563ea9d6313.1680225140.git.wqu@suse.com>
In-Reply-To: <9a96394d97db24ad695b7f89f2d28563ea9d6313.1680225140.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6475:EE_
x-ms-office365-filtering-correlation-id: 2fcca85b-b86c-46a9-1b9c-08db31bfc65b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPmjKDcAW8RhoKkpLX6Ud6tvOVBIc5jGbPDtKxuTLS+OMDlDa2b9qgjVX3YCJ6z4N1+ypPzdt0LxtOFuve39hcWayxhLNTMby3o2F4LJMUJ6HL0f/te59fLqWEG85ysmFSAbwEW3G6SHUixJIZPvU6GGWEMQYGm1D+vA8v+Q8e1y1TB6MDTc0UWDfPMgbUKut988KWk9Z/mkDyCX2nvRcFvpdZv+bJjCLBTRVAcTRvqMXvGcalfdMYeg6E2uWoMqVmyHkqLFsruAJaswPYUyMQp206VMENqbk+nQk5dYWC5ZMwv9Jmf4Hu722yamS23mCQyl6tHCsOasd+mleG417p+jL05FIdzHOTR+IO89KCUUAm3B5ziL2/NBRylk9cFArMpD7LKRHZAHrbwr/7JKuN1RnrWlxDtpacsiN9Q2WL2RS/m5ku47hr4fKpLX9r8DMVZQkNFuyGKgqi3NDhFJW6+/utoh2yV1mbqTtSLxRCVgja6bF1ucFuDofyg9W9Mq+TzfkEkIYAC3ke6im1ATCRL1ycJ7/jHqckbW1FK0DUQWbuyzVghyRKx5mPMHSiisPzkfFN790CXBIa+lFQjM4pnA+rPNla1abatgTi9fT+K1RpLlnCwjHfvD8JuOO7S3JWndm+zOPA16txYq6kRi1VFhV63hWeswVt363ryjbxBmR8RMyRy2rj9ZE/HAvTxM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(2906002)(5660300002)(31686004)(19618925003)(8936002)(82960400001)(41300700001)(6486002)(558084003)(76116006)(66446008)(91956017)(66476007)(64756008)(66946007)(8676002)(66556008)(4270600006)(110136005)(36756003)(86362001)(122000001)(2616005)(31696002)(478600001)(71200400001)(38100700002)(26005)(316002)(186003)(38070700005)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThrOGRGUnhvTkVZankwdDZZL0tuQlhvMGFqMmVMM01BQkh6Qldyc2pHUVAv?=
 =?utf-8?B?RVd1bTZXYWRNaHNaMG1DZ2p6NGlxS3k0Wm51QXNNc1hVYkkzV0ZyRThlWE1a?=
 =?utf-8?B?RWxEaGtjQTl5Mi9FcjVuSmpMZ21xNlYxRlpZVXBEbVFGZzBHWXd0NDNIN0tJ?=
 =?utf-8?B?VXNuTTZ0dGw4N1FmenZVK0J3YUdqcWM0R3VGQmcyeFV0ZFJSWCtqUjJOVC9l?=
 =?utf-8?B?SytaSnhzZlM0YUxIYnlxNVRaK1NlWDV6d3NkSVA4RHloUHlmeXlaMWlBZXBE?=
 =?utf-8?B?eHVjRE9qTHVZbnVwdHIzc1dIa1RyeUxBUktaK3N6NmtBOGR1ZGxnc1JEa3N3?=
 =?utf-8?B?eWo0TGtMUDlyN2V1aDkvMnFUNVBwRDR0WW1NNmdPc3pwTUlRV1loaWl0emFT?=
 =?utf-8?B?anJlaHBzb0ZhOWNzWVBZblN6Wjl0a3Y0N291QjhYdjhYZ256bVQya1FhMEYy?=
 =?utf-8?B?ZGxrRUxUZTRkM3pnaS93NDhRZFoyc2tPOGIwNExaeTM1aHVHVXVhcVVwUXFP?=
 =?utf-8?B?WHNqT3I0UUx6NFV2d2JZcVBOdmdyUUc5VmVpWDd4NWd1S1IrU2F3S294NWwv?=
 =?utf-8?B?d3NXelk4bGIzU1FWT29ndVpTVWg1NUEvOHluazZRWTg3am9waDFTREFXTkRz?=
 =?utf-8?B?TUtETVMzZTJwRHFGdU9IMEtqcWcwUzBiVXJaUURiRGNoOHNNSHRkdmFLNUor?=
 =?utf-8?B?YjdvbkJLNHJYS3ZkV1dJU1N1cjFIczE4VnZ0VW9HdmJaNnVQZ0NoS1d4MENY?=
 =?utf-8?B?eG9jQkpIaWdDRlVXdFlkdmdJWFhnSkVuSVMzOU55OUd6Mk9GZWg2T3o5SDZw?=
 =?utf-8?B?UGlGYm92QUNTTUxaUyt4WDlMQWhjV3pnSEZBOW1KQTdWT2t5QTloTzdXdWhD?=
 =?utf-8?B?S0NmSGtDb0ZZUDJUejZCalVsVE16KzcraUduTDRnbUh6VHNLVmtybHFodjVK?=
 =?utf-8?B?ZkUybUZ4bERoeEtkR01VbFl1TnYxam9weWJObktEYVNqWi9BV25lamFKSWlZ?=
 =?utf-8?B?ek9IRG1RYVozQTQralNTSUtOcEU0ZEJkYUVyTnMxdTNXN05rU3hCWHY2bEdB?=
 =?utf-8?B?VnNaRGNxTmRuMUU5N3dQK1VmbXc1SzJSWjVGRjVQZHpCS0pzWGpzVWtXMWM4?=
 =?utf-8?B?bmNQYTVnSTFPSld5NUlHdGt5U2F0MzFWTzN4TXF1aktJTGxqQTJkcmRGRU1I?=
 =?utf-8?B?YTJCcC81clNRUTdiYkJtQkFMM0w5WmdzMVpoWW9OUityZUJhUkZBK1hsbkFC?=
 =?utf-8?B?U0N4R2wxZERsRjdkU0VkekJJamZpUkdsV2NZVzlqZVViODVvYzVjZU04Z3o5?=
 =?utf-8?B?bTFNUmFiY0dlaVE3K2IzKy8xdGxqRWs3ZnhSNk5YczU2c1Y4WEVjdnBjbkYz?=
 =?utf-8?B?MU5wV0trZzZnRUZya3ZqVGwrSUt5VW9IcVF4Zlgxajc5N09ubnFEdnR0bHg0?=
 =?utf-8?B?MG9Ca3U3b2RFdjlsbE1KdHl6WGtybW9GWkJYaEQ1aEZFdS9Kck1UZnF1aWtz?=
 =?utf-8?B?WjVFa3ZxbTJaL0JsdHlVeVMyZXRHN25yMTM4M1F6UVc4MWFvd2x6OVhUY1NG?=
 =?utf-8?B?ZDRjWVM4bXV3bXFsTU9SV2VpcStkakcxV1BPVVVJZjdYb3lacmJwT29ZeFl3?=
 =?utf-8?B?UWZnbjd2LzN2dmpZTW5GSWhBVm16OGhuL0NvaXJURHVjd2V5ditubW5IR3RP?=
 =?utf-8?B?VWV4ejBXTTRBZzEzWGozbUQvbm80TmRESTZabnpVWXBxSmpjUVZBNkEvUkll?=
 =?utf-8?B?N2pCSG9xeWFHdzRNZ3F1NGtUWGpqTEw1elRyMzJOOEZ1a3d0aXBUWU4yY2JK?=
 =?utf-8?B?K280cURSSENSVjZPN3I4Z0JCN3kvK1g0WVpTQ3JLWkhVV0F6bHp3djVVV29I?=
 =?utf-8?B?N1BEMzUwdVc3Skg5TkhxRi80VkNmVUljeHpDTHFxUTVzZGpTeVZsZ2hwWnA0?=
 =?utf-8?B?YThkWWxzOFpKT2VXVGgxbWdERHYySTlRRUdodlhKeUxMNlFPUDdtWVZJb1lo?=
 =?utf-8?B?UEExUVErYy9RTGNPS2Q1NkhkWHk4OTRwZWNvVHJMWElQVEEyZTlSV3pmakRr?=
 =?utf-8?B?N1RNNWQvbnl1ZmNpaVdzM3lwUWRaQk14T3pxcm9BT1BsVXhGT2hVUUNSbXNw?=
 =?utf-8?B?Y2ZWWjJvcGRoWjdLem9QK1pSenFHaDNmN2NkaC9BbmZZOE5WM2JvaExRTzVp?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14393AAED763DD4881516D53108180C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mbTh7Qql2I4sgLtmM5vIW5RHbVoziy+WyFoZQD9zSY3KEO7RawpEWfWnKbanM28bEQgRslmg0PBd7uZZhbjaX7e7vveWnHgOlfIdJ+k6WW2wz/CqdPSaqnFQcCnQc+FRJF1zg9r2PpKnwq47b3Psf8ehkO3IRW73ATHywwDSzCJEj+SZmvuHy4o+2hFOMQTxW54ZR0rSp7pJUUfX6YpYcfUHO83LOEzKamPs9JYrDLyJdBKVgarb9wuCqgYR3PUgm3o5LTOz+PrGVy4OaIK/7TxCq6HPUjyk9vBje0IjXCc24NU/Bk2d210tUd1sZIuoCYXQdU3Ketti/kEFd8zdJl981rlm178cx0kCH72mfKU1vJ9QeiAoc6t/GubCGJF4ltahKeh12qBpnFjSzrswRaM8gyCbl1+FPkjdU6XaaR6aUOXc974eqY827B498J3NFOeXVZI7yBWlB2CCAR+egmG7zoSkmDydbp4q9EzzmyjhdDVaoF3NPb83d/NvRR36lkx8bM9Yv6orIfWaqnV/MP7PYI6HuEt9fp6dO6lsGHlf65gFNlDMglIy3YsedyEZ/t6Gd8jOlGuiFn47YicHYdDdn6uwNgBK/nEfq6jMruCV/H7kMbYbRKUezTTpTwDLcv6Txi4fUYhlSMd/WN0ZCWbjUDp7iPM+HdrL6aGpdcGa6La9fL5TvFucFiPz5kCAW1Xb92pvVyOntHnyocmWYSr5SK5haAiyCYSHcY11XYjDPwYnPHpE4dTwi06aD7byOGa+0+UKzQ/WLUR1o7nDSrYKu9IQQWlQ6QL+b+tNJ9zKC0vKHQbKl+0fDS1DxlLH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcca85b-b86c-46a9-1b9c-08db31bfc65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 08:13:13.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcxJUR2MYSicXZhBQZmT17FWXEVB/VSU0t3lh04RIUtBs0SlxirlpSt77r5G2STAwaQ56rk2RZSa/rsLNwwXcyZNfR9396zgwwI9bPsjey0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6475
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
