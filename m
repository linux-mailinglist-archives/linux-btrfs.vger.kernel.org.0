Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B349671079A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjEYIfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbjEYIe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:34:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E30E7D
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685003664; x=1716539664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LfQy7aWYxx8wNBGOzFRkGgYP1Gp2bxkpDuHdQ/YSakmCI1XB99RJclm+
   /5+yv9CgAMk4FwjTMkZqDhbwS/mSTm2PGA9F081PM4iFLf1ElvpRlMHlU
   un9nTiQ1HOcBC+JrrIk75BRfqq8r79b/wNUW6liWm9YPJlEFul/bjGZlg
   JhbnWhw8D0bunEhKlrYgKNzRozkCG2aT5E8/LhBu8wcqAMc7wjT2sjfQq
   rYtVXZMQuEMhVYbllefqKFlOdz7qUWWd7XIhbHXyIUgVtr9r4x/kACE9B
   ehb4SaZb7I9nhjpnFiopVClPeb34SEVHIXSdfNrIva+jG+eyaluPaSwc/
   g==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="336082483"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 16:33:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4TrfAvPPFOsRhOzjN4CmwWDgZ/UrpIokRbg++N3dLICO14oNXHD1VfDI2yXdnzInSSgSEGqfL+Vz420WHzhapNBXSlXKB2Qah63iH0qB8iabLemnX8L8HBhzkrtMH97wvufs1F27EFQLwuoOFFqSFIF7jJsO58Z3AKjJbBae3ed4erZ76DNl+aMfVZrjobsDgEKxWSv64XWKg9h3bJjIZDiAxEyrBbOnVn08Ly5S7qpBZ89ykG1C5H38nKdWAiMG/s7UYVJxozZe5CCX4ILE2YN28g2+UQz33rTnDUnr2JOj3+YaqZtTdpGN0FFJUkKyZVUN1s9VvAJCqFUkf2gaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=R9H2+xtrZkyB54do8UOIj65eLvNMpqUZeakTdcr9w+p2TUexns0r/WUkT7H++/QcYHon6qGHHcXiM7T/l8zmB22YwGb0sB9juZXRty+GLKI5FEIwcYd/qUyK4MfeYmZd5pOh3S5Q5z4l4n24Wi5DPyU291c6qlMCA/VtGHL4wHwyZ7OcO2uuuSe3u9P3MRHoAqwkBdeLrkSD2RL0UzqW/50+wQVAsUXemsK3ewuobVEMzGSvtCLQapXRIzHYXatOTdh6IWG9yxqR6oKMpLCYFj5CGbdCHEaV6Fp0Q+gcBYqIauRzEBGXF+AK2gLm4Ft1vGUk87Ma6RsFqPgAA+Dgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=rv3Sbq0v1ndME4K7JedY1qydoOpvpcmyo7g64VvV8OcNSmon9GycRmZeCr9wOF8tEmGsofTxMhV5cSSlSGTUzEpIxiJX4R7ZMYMtBYXLDs045K2z/AnjxfD6aM+vbWWq+XQQiaPJ/DFPc9bDIXLqAaTEqPo6jtoPQye0G3T2csU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:33:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:33:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/14] btrfs: optimize out btrfs_is_zoned for
 !CONFIG_BLK_DEV_ZONED
Thread-Topic: [PATCH 01/14] btrfs: optimize out btrfs_is_zoned for
 !CONFIG_BLK_DEV_ZONED
Thread-Index: AQHZjlDuq+nckxz1akWvmcguBEyPwq9qqm2A
Date:   Thu, 25 May 2023 08:33:07 +0000
Message-ID: <2d90b126-53e0-33b1-1164-0534f869f272@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-2-hch@lst.de>
In-Reply-To: <20230524150317.1767981-2-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: bf7d29c0-d9d4-482c-5144-08db5cfaaa84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esKMoVSSpt/1uOs097nj6vVQH+3wuy8iCRpib3gf+ntK/IvqDjQ6cvhugNVMjHJBN08NQL6iafxrebpiFNWY0Ky/IpI3y9e3UIiiHpiasztOWdzrdid0Ayboic2YaFDY8grMrW0BiCPpjOVJDfihPZotDLn88S2iMO1QtPOcObRRizK7IGA8rgDCoUw2DQm0AEAWEMyeBM3ivevuOiNO3JmoLBjlpLG+wDyaLmA62gtGFFgPYLcdMLgkKijkg0cEAdi3yx1gzz2F1+BCpylK52rdHd5ewI9nKMe+HWaLb8ByTeiCxLNl5v3jHB46k/D5GMF0uKPU17FubmX3ZKuMdkFgHUYfXvI9rOnzTkbALN6f/Wv3psHDDFFHlQQNugnoav3pldbhJqzKUtkRxO8uIZ/3b/VH1rveZMvA6tOZ9IpYj8JJn9fF1+ra6oZ7ldMv4J1VSS1dBvwhyFJuA5ufcgJYuu+AcNGX0GnAB7SZAHtUuuu879ZyILgBoQri/oGS+qPtKVTPMMWDd3ccjRHvrHJ9i8PlsT+gcD2qDdGuVtJHB4LbnCX9gBOvkwR3it6f0RUTehnP8PUjbKBDur+6r90+ZLsRI1/Ndc/hwWxofbZKkDnbjn6Q9b1ZGFKXON7EGy1FXVh9fDKbmWvuMW7fmehJHqFDLwHI/PZzK53AJBh4IwfvyQryuE5q+iN/zvC/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(558084003)(38070700005)(86362001)(31696002)(38100700002)(122000001)(82960400001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(4326008)(71200400001)(64756008)(91956017)(66446008)(76116006)(66946007)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWpiNnVVSVpXVWtyZWwva3ErNlF5S1hPZUpEVk1zQzBNcVEvaVdCcTJRUDlO?=
 =?utf-8?B?enVIQWZHVUJ3UE85Rms3TDdWUk1obHUxSmFBM2F2MlU3eUlTa0c5U3pqbXNC?=
 =?utf-8?B?amJKTCtoS2d6Wk9qSW9vUFc1aE5YM0s0V24ySURCQ1ZFOXFjNWNFajdiSEV0?=
 =?utf-8?B?RWtFY1RwT080TTk0YjJ6ZjZIQXVXTW1ta2NXMks3TlpUb3p6MThjL3NiZ2Ew?=
 =?utf-8?B?Wkt1NVpzWHdqT0cycW9iVEJpSDBwS2k3YWlZc2dtS0VYSzdNV0ZLc21RL2o1?=
 =?utf-8?B?MEU1eFM0THVpV2hTdHowa0dGWTJmQ3Q0MnVyVWFWMkNYU0cvNlJKN2JDOVhP?=
 =?utf-8?B?NFYwZGljSnVYNUVlUndQVDJCLzZjZ092WmllTzZuckRmc1BsRDIwRER4TnZZ?=
 =?utf-8?B?alowRGYySGd1M1AyUUxnM0l0eUk0S0FNZW9zaVhtNVQ0UnYyVFIwa3FvODBQ?=
 =?utf-8?B?cnBNM29oVkFLbExxS21FWUpVU3AwN1czT09DQTB0R0lMcjUxMHVqRWVkMDNn?=
 =?utf-8?B?cGJFV2k1NGMzNmVTVisvYzFMWXJQejZSbW5DdVBjKzhkL1ZrZjdQaEpOQnlN?=
 =?utf-8?B?Uy9QaFQzTStPb3Z3TWo2Q2JuN3J5cDF2akZhMTVNU3JoZjFPRm94cEtCL3Ew?=
 =?utf-8?B?VGZLK21RN2RWSUZOYm9ENENsaWQvRkltYkpLZzFqWkp1SmxzM2t3QUliRDBJ?=
 =?utf-8?B?T1puRXRIVTZ0ZjdTS01hRVc4THBlUlVaKytwN0NMRTc0cVRDc08vOTNKY0tU?=
 =?utf-8?B?YjJ2dFdvZnVVQW5GRXQ2YmJaNlRkeExvc0IrSFd2bkpiZS8xVzduNVNmbGph?=
 =?utf-8?B?QkVycGZkVXRSTjhKYjBEZlhCS0xjQmo0a2N2cW9BM2RkSjhpOGMyaVVCaytJ?=
 =?utf-8?B?cEdyU1UwMVN2V3FiSU9zeFoyQiswYkpiLzJPbE5EdmEyMkdjUWFNeWk4SENR?=
 =?utf-8?B?THg3THhRNjBlQWlUMnk5cXFQSnErL2N1T1VVVXRwcksvMjdiSWl4NzM2MFJV?=
 =?utf-8?B?Y3dDVGZZNWZIU2ZJVDBkSG1MSGh6aTZCWURRcXdyZlhrQ2I0YS90a24xMDBs?=
 =?utf-8?B?aUpEaWtkaUJHaEE2SmxCMnE0OVhnN3V0b1BmWWtXeDlKdU10a01jZmhrS0Jz?=
 =?utf-8?B?ZkRJZklpejlNU3dOYmg5bDVua3RUb2FhcUdiK20zYUJNMFRTZ1M4KzBjUVhs?=
 =?utf-8?B?SEZuSk45UDJHRVh2cXZYdlNZem5pVTUwZG5HMXgyQ3lsSkZYUy8xVHpqVFVl?=
 =?utf-8?B?ZDMzM1R2Mlo5dGpSeEZGTnV0MEZaT1VDOTRabmo3UTNOdlVVUzdqd2lUKzJL?=
 =?utf-8?B?ZWg5ZjZVQzMxMjhNTXdkSkx0WnlpRC8zd3JLZEVDTUFqc0duNGUrSmFCV2Nr?=
 =?utf-8?B?R3pjWlg0TEJrNEU3WDFXS002bGZPU0tXT0h3L3pwR2Q0ODZ4YWRka2ZLQ0pl?=
 =?utf-8?B?QVJIRlhvak94V0V0Z1hxQ2ZaZENkSlllUW1rTVRlK3Y3QzFXL3RPcnlsV0g1?=
 =?utf-8?B?WHFLOEp4UjJEZTBDeFBXQkJObHdEYVFDakZMTEJQamtMNmtOdW4yejZ3dzMv?=
 =?utf-8?B?YkZWUnRsMmxkWmxJQjZkcWtuVHdTajhpSEE1OXllNTBpa1BCVHlBUDVBQkpj?=
 =?utf-8?B?L1BDUVk5UllHQzF2VnZwVzY0LzJUNk1zUkl4YlkvNmd0dlJUL1NLbS83Z1VJ?=
 =?utf-8?B?bllBZzZ2Q1FXMzZibTl1WGdNVEFKMVBQVUJjQ2luTHFieHQ5dE5sMFBsK1cv?=
 =?utf-8?B?cjYwUGlmS0VkYnYyZ1FTU1JxTzNXNzZOemlCUXRZRHpJR0FEc1F6a05MaXhD?=
 =?utf-8?B?M2VXdTd0QkdKcUNqWWh5UUhraFd3S2JxUERjUFdZbzRVeU5HZGVNdHQ5ZWI1?=
 =?utf-8?B?QXdnSlpCczlGZ1hjOGNjejkyRTl3ZC9wR1JVTWljNlJpOVBIc0p4SVh0RjVJ?=
 =?utf-8?B?OXhHMEhhdEExN2gzcFJkaTdHa2p0RlZmN2lPYmhDUUo5QThKSzJBdWlOWE9i?=
 =?utf-8?B?Z2ZSakdITEY5bDRJYldpaW1SQkNMZ2VFS1NjUGpDeSt6ZE5iODU5UHpuQ1cr?=
 =?utf-8?B?RlZmTFNlT2d6OUpJOTV4bDAvOVQ1cmttTndyYmZCTlZxbHNWZ2M1N0l6OGtG?=
 =?utf-8?B?czlRcS9ITXBDNDgvTmprbFBmRzg2cXJLMmFyTGN0Tkh3UlFmWGdpQjBXR21F?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43AB5CEAC399E34F95F04FE52AAAF1EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ePdkQUpaTJbpJ+4a34tsGBFbec+J6fynjpefzvDD6Rj7E5o636f56fTdSFCLSfkMcsqEFp910rBGUt4IEywHfU4NtZ1BDLN88Vza/okJg3tnUqpwLYAlRS1g05zOsELh+V65+vQRkJGrYw370hRVJsWCao7iRp/BwO7qzo9iNTlIGcdErvhpn/hvcW8CksYYFiSvXNsABk8SOpZ67u8c0Jdry1n7VfPrKicI34zk4u/IPp6iHqd8X9emdAcME63LszneUiHz58c6qVfGT5C0awv9/q+5UyZejiGvEbONNdu0NhebSTB/APx2B5KjeOaAUg26maCqY4lpC+VYk3YPqLMAYgUMEJcrAMtD9RL+YMaEgVfrWOaHTg8+Dnb5nt02bDnhR9E++TxCT9QUdAQWZjcexhssxqiJmm5933RGD5dbrDVdaptledOpZVDTPIDPTsXIcJ8GQyIcKSWWA9JLG0DFehkw/dZoIVP3Ur8pWYsE7yfSCcwadIfDOUM+M7B2/vJPbFzKgWZ+gD9sCoBtJueYgVVWNRaCKzV9ojM0KK/wDjrTzCCk2HJ5ZgdSXV810+ShZGVcVd+tSSgbDUaF48IV1iTue8JewjpY7ihWxarLRZ4z3J1Q2EmttD3J//xO9HzF2tOPk/SBHMH19Fwy5KpwG/WFq2uGww141wp84OiAYxLZIUsOsvU8of7Q993LdNv49xkrDTDiafb+gQSxlFuveZjkTfcQgRd9BK5U0YEkuWld7SsNkxtMG1N4RK3N2efIUb3Ukvt6Fgjd8WsRm40unFYUlAs90zUfnV4LL5Va/R1tL7BxKWY3kBFP3w48r/fVKT21Ech/uRttZ+MQc7VBj+LL1siu/PRSY3RIUlNNo1QtBwko2JQYz3fdGvYQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7d29c0-d9d4-482c-5144-08db5cfaaa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:33:07.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UGXKJJ5Ffx7p9mXHtjnAWwvaPH8m8Lrx8DGlyu8DsfG4IwVGOPT9jpXmbQR47xSoU+4lI38WMnGjKZUTVVt3+amvf0aowfOP0dFQmNC8t8=
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
