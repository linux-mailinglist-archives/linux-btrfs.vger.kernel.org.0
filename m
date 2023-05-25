Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855897107AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbjEYIgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjEYIf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:35:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E73E43
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685003720; x=1716539720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FdbF8uYi5M+KO++1kR/5Sj7qSLnCaC0DT+pMpm68kNpjQfl1Lj3dq+Rb
   WRK/TWrj60DMwjH+a4+5xvtDpfEjbzreoFDxea+jplJP7yVBylJ7c4OTs
   rnxCYb/DzoZOIp4RzmNEKyBb4h85fVhxXfHeYfCgZgXVxI+HuLet69OdZ
   kk76jlg7o5jXdqv1j/GpAqxzN907CRTgRQb+8FK58AL90Ql8JzVSEhO6j
   +qXpHcB7D9kytR9HGkTvFZqbj6IRSBP8ZeF4yHkEJlQOb2U1R3CgT1YjR
   qzfv/3XSkEi++P2rgmTs+MW791TGIq5URDVHaPNQPfw++3XSES0qQ93Dw
   A==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="231624155"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 16:33:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja7jAO8Gf3p6jKFb9iyBRRrsFsh7RhgRSBp3UWBNt1w5o8R7zwaBtrMvsLZ3AjRbpKkAFZVunNidG6Cpd3mF3kU8hBlnvjIvn/1+BxFog33AFSUaIr7XHaxQOqXZeQ+rATVQMewyPYJfljmPrrp6StqyFK4lvHplavBs7Iujf6uCiRjL46ayWjjh3PCWMz5STYk04mx8q7KEdcB44fhZmGZGIQ5DGlbUJ6kA55HZWUpKWknlfVLqiBOfHpBzj7XuRmKTw4sP0fNDfNQgws2/ULXvRHN9GsyPWh06eW9Ug9rErUSrnoTKATtLYYg7HbyxURMGId37C+DPDdw9kCtX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=INbwUhRhg0MEoGrePW/XMEfmJP5Md0JA1LiMFS1bVyyiQ4gUrIVUer9yjvynqCgA80VUrT2D9BVHFjyCQ0VFp5jawMrxg5xEEzUSBKEF0E+KrrlxuprRwIyO4kiyTiJ0xe9zT+ZFhjgAARcCC2puVFSWQnsMg1fZGrDFP5BjVoT/hu7w2Xoz3m6eXllZHFlCJ8eZo4+D6p7oCM8vO4zLUvy/ZMqzPShQasLVgC6S3AphBEtQNyB49YnI8ZtvrUHrGxbar6c3DFJ04LO1SGic0WqPpg/YDUAAWhpnaJN07ERhStmu25kD+GQ1D69bWqDNu7oGI4dxVluQRko3RhTQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jk15U6OnebbWaXTII4mZOIei6nmhRqTB+vHm57FY7RAn0U93Sjo/aKtkYkQmW24YYE3gxlAPW8hp9RNh85RYZGmvZfHmIa8Un3+GAlx4zJpo7ruSzxralIf5q81ZlVHgvTrdAC6Q2o+ZM2jpnikXtUgsp4+9QK9HNQP+QWitK2Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:33:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:33:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/14] btrfs: mark the len field in struct
 btrfs_ordered_sum as unsigned
Thread-Topic: [PATCH 03/14] btrfs: mark the len field in struct
 btrfs_ordered_sum as unsigned
Thread-Index: AQHZjlDsmAroIKcwD06t/1HeCtV7La9qqoYA
Date:   Thu, 25 May 2023 08:33:28 +0000
Message-ID: <e5722fda-ca1b-5511-53e3-5f07836e8288@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-4-hch@lst.de>
In-Reply-To: <20230524150317.1767981-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7436:EE_
x-ms-office365-filtering-correlation-id: 0ae29209-e22d-4793-da19-08db5cfab74a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYX80dwZojikXv/8CDgi3Ww1ypnIOjSiOWBvBcwlmtQTGNInwaagCxYTzB2VLcQOQa9OTDRR8OYjSh3uxkY4WdQytxKUJEEuwc8UQIVhXD0FpF8OWUszmB1J27GNvOucPsv4u5ocV+b7U8DnflHH73CEroBC5fP40Rpl3spBVHZHHr6JkGkjmRcFCItO+cEYH/OH8y2eIQCT1aDFgQpQml3iuVrpf3E+gKafSwylvJ0nj5PAA1zz+Dwe00GgxtU6B5otez8rzlexEr077CtU6Zjst3uwBEdqAMP8+NYlM3NawMjIM+1OkJQzNtHKiDLHBNj+/mxbEJApMpNTAH1gIdE4vK8j4A1vWDoObHj1gfDsUfvJiumVcrtzwpEC9OeSDXk1KVHVD747p5Vw16qrtpr0ttOW7MRvzOYhQchilSm5s+HLW3ClITmyRK5rgS7XGB4kxO9ZtIDxSRYCWnCPtd9dbfJJq2ja4xgei1Xya4q9lsfcXN9pzfKxG2eM/6qZT5x3+6jpcqkjTF+XsBeMQSTfWkPGsKS/Y0H1X2jWcW/R6xcdy6EmvJdhaAwxo21vzX68O2TbnMYFcIeZRBYRn1noMVEjAzI+xedXq3dhefFZmd4MV8NL4/V9z3JX+ptuZ9cMh0QvCW8bxB76W9qWbCJe2n3Wwmktoz2lRTVCtNM1ETyG1K8LJ2BsRbu/8pSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(558084003)(38070700005)(86362001)(31696002)(38100700002)(122000001)(82960400001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(4326008)(71200400001)(64756008)(91956017)(66446008)(76116006)(66946007)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjdBcXgza29UUW96R2J2REd5VEx2eDhoNEFLZmtpRVNZN3g4VGVTam5LRFkr?=
 =?utf-8?B?WjZ5UE9NT29CWVZKMzBhY1RXR3ZDKzkyQTZJMVlJMFNCWSs1MDJvZXhnZkF6?=
 =?utf-8?B?YkQwN0I0cHhkcEhoRFJZMDMrMmdCbHNZRm8rWndRTGkxTXU3Ui9oNDRWUXE3?=
 =?utf-8?B?NS9iNFQ0NVpFK1dVS1FBZkxlNHBSOFRhdDh1WGNCdk8rT0xMckQySXVvVXQy?=
 =?utf-8?B?cllRMXZIL01YRW0vY1oybkVpdklqaDdPVldlMUlHN0QxU3A1RDZlcWttWDYx?=
 =?utf-8?B?VnZBZzdxUmlVN0F2aTgwV3cycnpRclBUMGF4Y0xCYThibnFoNnVXRjNrblhz?=
 =?utf-8?B?d0NaTlBsNk9YRW1LbStMLy8xaGVMUnJTd1UvY01GQ2lOOUdVSUR6NEtHall2?=
 =?utf-8?B?QjNYajQ5R2pSZUI2Yk00ZXoweVo4QUhuWENHdzVvSy9ucEVDUnlRL2pDaVpw?=
 =?utf-8?B?SFJ5dWxXRlcvR1FpRHRNOHloRlg2WWMvbTVreEhHa3JPNTIyZ29UME0rQjlm?=
 =?utf-8?B?QVhkNjlQQ3I2LzJBWXFJMHkzbWUvWHlzSko1eFFGVVRYTDdvdk9BOER4dlM5?=
 =?utf-8?B?akQ0VE9ENjEweHJOSE9KU29CQWVLWm5CTWlsa2lQNUxQWUFoS2VrTmNhQldD?=
 =?utf-8?B?RDNLbllxVlNxSWFEbUQwM05oUkZySmdNVTBCVFU2b1U1UkZPcEcvYWJtSUph?=
 =?utf-8?B?bjVON2QyVE1mOC9Fb0dmME85T1QrWGRPbG92MHNEK3Q2SWFFS0FHVnRpUW8y?=
 =?utf-8?B?M0lHUGRnZTNMclFBRHRPOHBrMjZna1NLK25yUDhjRTV3Mk94OWUxcUFEWm03?=
 =?utf-8?B?U0twbnNTTEhPQmtxSmdIOWpEUnNvbXVKOUdjYnFFbXNWd1JxbWxzMC85Z05a?=
 =?utf-8?B?bjJFdVNGbnJUYXFwRS9uTEdhOTRHNG82UFFwNll6K2lCMS8xbzI1dzdYZzQy?=
 =?utf-8?B?ZHczRG8vaU84cW9FK0ZkTm1SYzJqdGNMM0F0RVFkTTUyTTkybG83c21VUGZm?=
 =?utf-8?B?MmNPQ3p1NytJNmlOU0cxVTVDTlVpaUZSUUJyUlRMbjlqZU1kakdyVWxTUGxn?=
 =?utf-8?B?UjZxT0l1WUphdEgxUDlMVUxQcC8wUm9zUzFsNVIzdHZZbmtCME8wT1RRMzVF?=
 =?utf-8?B?b0wrL01nam5BZzkvUVY2QndiQnNPa0VWTHk1TE5EVWdLVi9EM1VwTkFpTkNr?=
 =?utf-8?B?M0FIRDBMRC9pTVJFS2V6SjNWaEdNdHlhSjZVa1YzOEQ2QXVOaVJRR1NKM0Fs?=
 =?utf-8?B?UW12eTNGejcwN3J0S29VSWZESGswWUMzYllSZWpYa1Z5Y2xwLzdpQi9tWmNy?=
 =?utf-8?B?dVk0UTd6VUp5SUdPdUZubjZRZUpjb29BU1pXODd2QmFHbStMeTFqUk0vMllU?=
 =?utf-8?B?Z2hDVUpFSGNxYW8wL0t5V1NpVU9yUTJuY2R1bWdaWU1hUlo4c3B2WHZUajZz?=
 =?utf-8?B?ajc4b28veGkxekprRXdlbStVREQ5UmF5VjFNcGNhMG9nSmlTRjNENkxjaWIv?=
 =?utf-8?B?VkJnWEJGMXR6dGhPVFBLblg1VVBTWHJXTyszL1B4Y29iYklxdE54WXJhRUhr?=
 =?utf-8?B?RU1maDNucjE3cHNOMzlrcE5YR2ZaTHNhSFlyT2lQMVpEQXArVGpGVXEvOHBY?=
 =?utf-8?B?Q0k1WWZYeVhSLzE1RElvOCt6UkFESU1zS2V0RnR3UUtrWGNJdlhDMWRFU1JW?=
 =?utf-8?B?b2MzdEpUY2dnR3RZaFh1R25PTlJpSktLK1Vpd0RKQk83MUJ2bzkzMmRPeC9V?=
 =?utf-8?B?ZHIwOXNpcHdaNUxudGw2WkErM0RIcFJRbTlaZ1RPdTJqeUwyUkY5SVl6OTN3?=
 =?utf-8?B?Rkd0QmJvT2Z3YlFPL003ME4vTCttOUJZL1dyYnBSNFdCZ1dyUzIzaVFiL0xS?=
 =?utf-8?B?T3BEUy9VZkFMV0N2WEdkMEgzMUVZaE9EQ3dvNFROM1JjMTlSZ2ljV1VGVVFl?=
 =?utf-8?B?SmtVV3lZb2JZY1NieXk3Q3BpcFhVS1B6S0tWZElhZ0EwRVFBMnBvTkxMeExG?=
 =?utf-8?B?UHRKR08xRFpvN21NZmlzSm9VM0VqYkJOZFNvZDE0c2hwZnMvL3RVa21LbG1K?=
 =?utf-8?B?S2hja0x6dVZRSmRYOGhqYmhmWW1jdHB3alRiSjJWRUtnYlM5SGhRYkpIQlkv?=
 =?utf-8?B?RHFmaUN5Ymwza0NzRVpHQmF0eWpVZ2JabTZLQ2NpWTI4L3hxNVI1R1ArRHRL?=
 =?utf-8?Q?QeZ3QrQ75m3Ee3mBUzBC1hI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7552A0ACB785804A8DC7B195DCD07D04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AROQnxebXj5u7hn0Xzaipv0jsJGfC+/H9N2UlkiG9j3g0DimW++tB57q0Cez6y7PO98H++WMhSBxtmH1hsODp5kgYlgYtfBnfNmbGfu5VdvQygEcSGJDcMBh+Nu5/2zifBl+pAFLhilB4jFro0M9NweufLgoIzzuqj/EeewVyxoRizIT8I3cK7xbno+hon/Ch9jMMLy8YK1gT7PhbOwRUAmVg0lmNNM3dB+xhlJd4zxz9XpuupL8anBgsPpmmFAppiO73QELM2EZ74l+0bxZyIO+R9umlWiiUdOpm7L0FOk+Q0Qfi4AJBKvN5T5F5RJwIYupQKCZ/2BFqX1bZuMcioIZ2N2/s6kIgAGGK0R91eqs+bbcWMl2RS1iRUDo4hFG7Hz6YkAt0vJJatCINBJBOasMz02dSldWnhlaQRBJ5HUqSoDaWbt7tn8TqljmawthPMCI4pTNV/k0aKTMPMfaLS2/Lnk5PlTWFI9jW+0mEP5K/Ur9WvNURAMg6K3I1SzYnG3ZlHKmOtDsnUIfiegQ0O7U7OV8bZAKEWP8SjcjZ6PL+TpmZTIYqC7TSj+WtskBevLEUxlOedyjDvFqppYbwUfD6nQK3rn3DHKZG5GfA5DNFqsm5LbbEZvNE2sUvGYVlk3p6encSpOEaiIkzhu07VeFJFKdWLHgmdTrW2SSCPumPknLUSzGRGBihvSbQCunOI/svJ9lI+2l3RouwB9tmd+5pSVECqFnmooaPED2CQ4w+9K4dQKkLqSTDNqeYTqq+9Xeeq0vjTTSNLmoMfqgZj0Fz6le/KGQIkBcqT+9Wx77p+o3YNqRHct091fAgocii3A2Ht6J9XRglGw1hXEwPByM5fDSawKIxFDpaq5HYWiGRboBaSQ/IHAq7/CCY4Ok
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae29209-e22d-4793-da19-08db5cfab74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:33:28.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/EL7MDbMiaDaT3TKgs/85cb77T+V5sxr9USjCxZTF2/GemNcXOh7cyi8MA6Ufc78fZPNk70NSY+aGgaMiDowhcaTb8SGAUdOT/7COG8p1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
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
