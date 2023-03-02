Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448C06A840A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCBOUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:20:24 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B47EEB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677766823; x=1709302823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RjGKGVAOBSkEKPmFapDmdry23rzUK0I4RfZvBapx03Q=;
  b=bPr6jQe0rd3vfaBSgDq7ILJGWw4EkvLj1v55HWcZZ4y1/I35AD8O4dJW
   dul/BD0o++5OSv+WvbqB1Y/YPWf3YVLukSjfvzf8IyasmoLog+kHnjDbd
   9iTGi5Z+mUvedrCw7rw0waEub6ZpM1ooNKuN6vm/9WzgsQmDGVfRTxO3r
   UTL+NTnQFlH2w3JhFkWdzMsHRcCEP+WW5ggcscd1ZNkR/igxHd4BJ5VFQ
   VUCY7M8kI9jzMYpr8kNPD0cvj2wwW6jRiT3e/9Z3yAGEEEDU8GN9hSp8a
   zphgqvRY2oBDb0xo+TOvj1QgCRzjuEElW2sc2hKiytv+aQAvK02McI5yq
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224634214"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:20:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8fNvXGWUk/+W1/dLe11G2AVEMoFn/KcdhO0FglXgdpUYCaVmeuX1OpMyzK2J/eEhNbLVoYqveL/T9BbTXpovV3apFqRdPePI7gU2UxIcSadJVOXCoy8i87oQe4egDAST8daQAObWywp2Q9xvc74BuQQXyXFVTvTLaZ4uch+ExdnJvM7khrKL7/pGxeivMBhLvnjm6WYsADYMOQd1WHGSATijXmBJ4Fnicu9KZ/P48kU/a9v5IoE1tmh7r8qXbX1w/InNLGuaNCPRpfimB2Ueq79IN6w2/WhJk7jhRDtc7oWAZkCzL5Eun0Jk+qprThfmV6xLxyvrCpY4NUvjxTYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjGKGVAOBSkEKPmFapDmdry23rzUK0I4RfZvBapx03Q=;
 b=PWYdpEMfttr1l3E/7nVj28FVOvSbh7CAo3KqDB33Z7K2nxmHvcsvgRoIVA7GfY3qcXtAmhEIcG95N4ZTfZRJzeGNMzGk0jvs3R9/HGqqlhCBboYLovYR3y4O+hvtTv2NLCwilzy2QOeQ6Q84Bb6rvteOVd4qW1QSGILJBae/ye5LToX15ixhB5684DdrtejAgsJ6me0vG1J6MLbGf/s/XctgBLMTPAL9VYS7fARyfmkRzJjHGBJP7TYk4ljI/l4Xn1Jgz4K1U4h3Z1Q0W9WpNr3cvarcHMnLKmww3U4TovD/kUJd3306ZmxzQqtjaTtAjXFIDgq40eJhWflT08RASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjGKGVAOBSkEKPmFapDmdry23rzUK0I4RfZvBapx03Q=;
 b=ZtAdRXhfKNw8Dh4vMx8gowr5oJm5hTh378pCOikwpfIgcEFFnALTSFy264WMsDJkDtT9MkDn0zyRi3vweNN2XHeYcvKwF/RYbxET2F+9ranFz2nolr7BRHC6dsqlNBUyQmB/g3VlOdnmCW2wlc2fmtztFmak21yvLauhHdrwGC8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB3961.namprd04.prod.outlook.com (2603:10b6:5:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 14:20:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 14:20:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/10] btrfs: store a pointer to a btrfs_bio in struct
 btrfs_bio_ctrl
Thread-Topic: [PATCH 08/10] btrfs: store a pointer to a btrfs_bio in struct
 btrfs_bio_ctrl
Thread-Index: AQHZTRIen1FI4irwfkWTpqrw/y/ZWg==
Date:   Thu, 2 Mar 2023 14:20:19 +0000
Message-ID: <e5ebac92-945e-0e59-66fa-922acf0f178d@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-9-hch@lst.de>
In-Reply-To: <20230301134244.1378533-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB3961:EE_
x-ms-office365-filtering-correlation-id: 74e1057d-51f8-428d-2cf5-08db1b294093
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpkOrKjJZaEpfn2dmmeXymZYqHAH49AGI3X8ctOpBLa/k+s4FFqw7jZVwdWx3yb9UOVnZQ6xonmaCT1kZzMhoC+/yND5aoS0YL9hSK9e5kEFNgTw3T6RE/iVof09ZpTsHCRKmjU0mKrvs2yq4c0fBNXiKXgSULA1NMniGNSlvKlWaYA02VULljnidSAaP9sYjLvY0ILZphSW47IPFVGZu+YPp8eFK0BIYt05h9MwBCf3hSCd5KGwQ+qoNBApf40xf7WV7r/jonxgBvWg4bpvhctDfPHBFWmtpySGfuUZrOA1jmFhpMLiIYKcjspI5LjtIwcW2H1x5UikcD7SXpB2UemryX97qlDgh9w9bj2VPiztkbX8eI+7MYGzuX/cPeZTtvAK2gC4qjtmddJVVdcUor9BcexlRLQI06yQOosLqg6cdTmmlw2BEawkk0TWOdbvVXDWJE2i6xuSs3eKPYqF0fMSk01lECZzGdhhuySP+KfJiARcJfwA3so+HnaNqcqi40WJzH2ru5QuGAdPxK9xySbD8FhVw6+AFvZHaBp1Qzzx4205GslpWP3nErkErkMkatKzW+ukwowGF+FI5cNkbELpsRddk58gBiuSikO7hH0wrXoOlMpFEuXZ4c1Rp7/9uTQlt0q9C55+2q/HTzIAF9CEa6CDu6qRLhd81ACGG6G23gL+VmfAEASWI1GMFm7gAh1NtBk5RNgOT/FBeQdfDuURgCUpsunkmOBUN24S47SAfhQ+nJ8tvFEFP4npi1cwSCfzigRFLLTZiFVZIlkgJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(91956017)(6486002)(186003)(38100700002)(2906002)(110136005)(71200400001)(38070700005)(36756003)(122000001)(86362001)(478600001)(316002)(31696002)(6512007)(8676002)(4326008)(6506007)(64756008)(53546011)(66446008)(76116006)(66556008)(66946007)(82960400001)(66476007)(8936002)(83380400001)(5660300002)(2616005)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVYaGU5WitWMzJNWWRTRkRVOHUvNmxGN3V2SUE3R3ZlUzZOUVFsOHpFYTNo?=
 =?utf-8?B?a1c2TSsvMDl1dzNHN2g1OHNZR3Z3M2cwSGxyR3pqbENsTmpmWURFWnhRSWtH?=
 =?utf-8?B?U2toT3UvWU5YOVlmRXFNdzhwZU5VQ0dPTXloWWIvcFlkTE91VFlCUlV1K2M2?=
 =?utf-8?B?ajd0YnltcmZOWmZpU0gyOElHREtTdFJlcUM4ams0S0hWNmkrbXZNWlUyY1Ru?=
 =?utf-8?B?d2FxK25PRCtSVFRFYjFlYk9MUXVqemRXZ3hiYlNWQ253Z01tUnZFS1k5cnFu?=
 =?utf-8?B?emExQzdxSHNsSzJNcTJiYmZOMlF1RW1IOXBpTWsvdllETENKcnZoOCt1TWVz?=
 =?utf-8?B?YWt5ZmViUjBpUi9FZXIrakFCcHJiQ0pxSFR0RWQrc210UUZnR3hmOVRLNmJv?=
 =?utf-8?B?SnNSWFRGcm5wSUhrUlovQ1ljM3ludmNOVm1WRXhEYXRlejhWaTI4eFNHVUN2?=
 =?utf-8?B?Z0c3WmpLK25uZVhFalZHU3F6SDFIaFdvY0RTK05CcCtJdmRDRDVxQi9KN0RJ?=
 =?utf-8?B?bVlSY2VpclpOd0tTUjE3TTRlMU1kUHFpV01mMjk2Nld0UHYzb1ZOL3ZlYUhC?=
 =?utf-8?B?OHlFTkh1QlR3MitRcmN5dFlIWUx4cEdtSEVUVjcvMW5NczNLVk9uN09JRG5T?=
 =?utf-8?B?WmRzZEEzVjQxK2tzMkIwUTg0TVVqQUpoc0c1bW1DQkpDdDQyRGcwbTNWSERo?=
 =?utf-8?B?Tmg1NlYwdERZWTRSeEJLSlB1aVJQYkQvelpBcmg5eXk2R2dmM0VRRC9jOUxL?=
 =?utf-8?B?aEo1UkIzS1RMVlVVbm1pNEZ3dkEvRk4wbWVuSHhNeDlmQ0FEaERsQ1NHdEZB?=
 =?utf-8?B?aU9WTFlPZkR3WkFQbE1OVFlMSVJEQldELzduYkZHN1pZZEVyNnhFWHRQZkVK?=
 =?utf-8?B?bjgzenU3OGFwSGhYd0c3RGQ1Zk82cVNINjI3SlpES3Vva0U2dXUxbGxJN1dy?=
 =?utf-8?B?MHF5UzQ2ZVR6UnllcGRXOFVUV0p4UFJJN253Q3l2aWlTWmIrNWgwUmlCbmdh?=
 =?utf-8?B?SkNLS0IrYm9sZzgxcDNtdVoxSmlzK0hIalE2SSsxMTRLV2YzQXNBQmh4Slk2?=
 =?utf-8?B?YnlaYnMxSWV5RjduajRGTEgxcDdXM2tCamtPNjMvR29mUWxKZnUzb2djRHdO?=
 =?utf-8?B?SUpIVTQraDA5M25qcmVDQ1RncENqMTdPZlRQNDhDOWxBRmUxaXRNOXFpRTJX?=
 =?utf-8?B?bFdMQkNEbTJ6Tm5TS3dDYXlnUGFwLy9pRVFJei9xRXV3aWtqbVk2T3BndXQw?=
 =?utf-8?B?Sjd3Mk9EM1JSQWt3VkUxTUxpNGU3Q0R6Z2R3NGpzQ0RHMGhxMldXaXBiVUgv?=
 =?utf-8?B?VFZTQjJGbUprcHd2cmdaSUFPTkR4TUc0MG1NSTF5TVRtNWJmUzlUN2RNcFZ0?=
 =?utf-8?B?WkZyL0xZVGpWaUVkd1VncXFyMi9Bcmt1R1BOOUVXNDFXY1pjMkZYdlBEeW93?=
 =?utf-8?B?cHdCVlRubENLNFlNWUw1RkJ4TlQ3amsrcVJVVmFQN3N5M0ozb1hRK2k5b0c0?=
 =?utf-8?B?ckFPYVUyU0phSU0yQkptSHV1OHduVXJIN0hsTzUxek4zWWZyNGJoL0dCRnhp?=
 =?utf-8?B?emhVN1JBdTAvQy8vdVlVY21XMllWN0MvZ200aTRsT3RpdmNJeUlEWlU5VWFj?=
 =?utf-8?B?eS9tQ2lPZXl4b1VaTUlsUlVpSm1kSWEzRXFXOE8rcDMwUkdFM2JXSFcvNWZv?=
 =?utf-8?B?cGJkcjlRczlNbFlQRTVKdzZsQVJqWDRIUTM1aGlvTFJKTDJOZCtiQWdNWEQ1?=
 =?utf-8?B?blhSMXp5RzlYUHAzbmhlWVc5akZDN2lVSFpaTXhpSWxTNjJPMVE0by96YTB5?=
 =?utf-8?B?OWlqOE05N2xVc0xtczNTSVFRTDdNVWRCZ0g2QTRQTzdmUEZEZm4rNGRHUExM?=
 =?utf-8?B?S09zL29QVDdYUkk0eEJLZmJ6SCtVOTRjTVQrVE9TMDNEdFZjWnRRaWUyaXQ4?=
 =?utf-8?B?RkU1SjMvdDhhNDZtSDYyT2hJMGc4aG8wVkR5ZUNibnN4UXhkc3JTdDFWeklF?=
 =?utf-8?B?MjRrVWt4eXdwb3Yrd284WU1EMmhoQWNUYXlJK3Q0bURnUlcwbU9NbXVjcE01?=
 =?utf-8?B?VUY5ZXJ4ckMzVnhHcjJ2dTIyaEcycGRWdmFNN2g3Y0JITVFaSFpNRnZVVytZ?=
 =?utf-8?B?aWx0NHcxQVI2dGk3QUFMdHhUNTludnZBSkl0MkhQL1AyTWIzdGpPdUZsWHdk?=
 =?utf-8?B?UGI2UDFPWW1WZHdpVjgrZmduck5tSlZNL1duMG5xTGdSbUhLMmd4WlZOdks3?=
 =?utf-8?B?ZGRQS1NMZ2V0V2tuQkg2bVh1ZzFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE4C2D9E712B794EB678277FED4D3727@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Igky3lsfxhVBbOSBZQZIHgZyOWrM7HX29zxXPEudcEDo5K0PlxAoMgFXNMTTIQw9S5s7azcomU37pgT4F2iyT6rW+XO6/YgdxhWrsDMqNq4cQvFI9DeIed6NfyKwihnT2kAVlMY6s5y+W9yXlUjh8S5FRGnio9SjwBYSiFNRabDET2iMX2RArPvzAnVnY+WBX0Tv/maOxwt8RZiHi8rMHB7OUcYDxvgzYrnUdRT75zDcEcUf6ssqH7qLuuDy6ufNv0WmP9J5dTXPBjb+hsODtvxwlhvtlv0X619Efi8Pvgb1A15u75tdjWfljei/25bgShgsKpr8MSkh3gOAkTXHsIEhOMLrY9lZMoECBN+5+Whp/la8vWOBciuLlnfRNeeVcSAaHORFZ5tTx9SOp41cDX5peX2yuTWquFcaLOlscAiZyiwHo1rN76KyVTqiVgqNZuj0700Hb94vt68zc3DOQnf41fU+oQMIXIgHfIBFPzbnxH1sWOtzAVuXNqIa2KVhzAJSxH/v+X4sJzGPIBE7BCeDxkJEBtTfDW+OK8RLkgg1s7S5uEybVzO7Q+GyD8laOHTnfGwxWDD490j+HR5jr9N+GV4a0e9p3sd3EfyEva0Wf6MrYH3Vk2yqP1ieZK+mwSZ3hMQO1p5EJK6Jka6+zXNAQd/BdAroATmwsB7KCVn33Dr/5BDPjI6gi/wsvH+1uLuIPT3hJr5ZktKABxjl2ky+010B9jeHLDBtaJVD+/e3AIJwvZ6u3o/Nz7tG89PAmJdq7beYwj/wHa2O6ez70bX1dZWOnvhBDRLcMwPFv4NmSFxW8iPeZNMpYIyyRRdrR3XPgu6+gNqxgnLOu+445SBudMz92hYXi1Ol/yfXsJcuqGudLeblaQxlgTLMBdm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e1057d-51f8-428d-2cf5-08db1b294093
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:20:19.3585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqXPy+djbD+tmPMimyHalZ4h+2OQwBZtebUSY+N4M6MWetbj0pXV82yGZmSuHRAtmHuwFkk/eYyJzW0VVosmpCIiVPYVKQkjxOu74I0Z8NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3961
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDEuMDMuMjMgMTQ6NDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgYmlvIGlu
IHN0cnVjdCBidHJmc19iaW9fY3RybCBtdXN0IGJlIGEgYnRyZnNfYmlvLCBzbyBzdG9yZSBhIHBv
aW50ZXINCj4gdG8gdGhlIGJ0cmZzX2JpbyBmb3IgYmV0dGVyIHR5cGUgY2hlY2tpbmcuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+
ICBmcy9idHJmcy9leHRlbnRfaW8uYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMgYi9m
cy9idHJmcy9leHRlbnRfaW8uYw0KPiBpbmRleCAwNWI5NmE3N2ZiYTEwNC4uZGYxNDNjNTI2N2U2
MWIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2V4dGVudF9pby5jDQo+ICsrKyBiL2ZzL2J0cmZz
L2V4dGVudF9pby5jDQo+IEBAIC05Nyw3ICs5Nyw3IEBAIHZvaWQgYnRyZnNfZXh0ZW50X2J1ZmZl
cl9sZWFrX2RlYnVnX2NoZWNrKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0KPiAgICog
aG93IG1hbnkgYnl0ZXMgYXJlIHRoZXJlIGJlZm9yZSBzdHJpcGUvb3JkZXJlZCBleHRlbnQgYm91
bmRhcnkuDQo+ICAgKi8NCj4gIHN0cnVjdCBidHJmc19iaW9fY3RybCB7DQo+IC0Jc3RydWN0IGJp
byAqYmlvOw0KPiArCXN0cnVjdCBidHJmc19iaW8gKmJiaW87DQo+ICAJaW50IG1pcnJvcl9udW07
DQo+ICAJZW51bSBidHJmc19jb21wcmVzc2lvbl90eXBlIGNvbXByZXNzX3R5cGU7DQo+ICAJdTMy
IGxlbl90b19vZV9ib3VuZGFyeTsNCj4gQEAgLTEyMywzNyArMTIzLDM3IEBAIHN0cnVjdCBidHJm
c19iaW9fY3RybCB7DQo+ICANCj4gIHN0YXRpYyB2b2lkIHN1Ym1pdF9vbmVfYmlvKHN0cnVjdCBi
dHJmc19iaW9fY3RybCAqYmlvX2N0cmwpDQo+ICB7DQo+IC0Jc3RydWN0IGJpbyAqYmlvID0gYmlv
X2N0cmwtPmJpbzsNCj4gKwlzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvID0gYmlvX2N0cmwtPmJiaW87
DQo+ICAJaW50IG1pcnJvcl9udW0gPSBiaW9fY3RybC0+bWlycm9yX251bTsNCj4gIA0KDQpDYW4g
d2Uga2VlcCBhIGxvY2FsIGJpbyBpbiBoZXJlPyBzbyB3ZSBkb24ndCBoYXZlIHRvIGRvDQpiYmlv
LT5iaW8gZXZlcnkgb3RoZXIgbGluZT8NCg0KPiAtCWlmICghYmlvKQ0KPiArCWlmICghYmJpbykN
Cj4gIAkJcmV0dXJuOw0KPiAgDQo+ICAJLyogQ2FsbGVyIHNob3VsZCBlbnN1cmUgdGhlIGJpbyBo
YXMgYXQgbGVhc3Qgc29tZSByYW5nZSBhZGRlZCAqLw0KPiAtCUFTU0VSVChiaW8tPmJpX2l0ZXIu
Ymlfc2l6ZSk7DQo+ICsJQVNTRVJUKGJiaW8tPmJpby5iaV9pdGVyLmJpX3NpemUpOw0KPiAgDQo+
IC0JaWYgKCFpc19kYXRhX2lub2RlKCZidHJmc19iaW8oYmlvKS0+aW5vZGUtPnZmc19pbm9kZSkp
IHsNCj4gLQkJaWYgKGJ0cmZzX29wKGJpbykgIT0gQlRSRlNfTUFQX1dSSVRFKSB7DQo+ICsJaWYg
KCFpc19kYXRhX2lub2RlKCZiYmlvLT5pbm9kZS0+dmZzX2lub2RlKSkgew0KPiArCQlpZiAoYnRy
ZnNfb3AoJmJiaW8tPmJpbykgIT0gQlRSRlNfTUFQX1dSSVRFKSB7DQo+ICAJCQkvKg0KPiAgCQkJ
ICogRm9yIG1ldGFkYXRhIHJlYWQsIHdlIHNob3VsZCBoYXZlIHRoZSBwYXJlbnRfY2hlY2ssDQo+
ICAJCQkgKiBhbmQgY29weSBpdCB0byBiYmlvIGZvciBtZXRhZGF0YSB2ZXJpZmljYXRpb24uDQo+
ICAJCQkgKi8NCj4gIAkJCUFTU0VSVChiaW9fY3RybC0+cGFyZW50X2NoZWNrKTsNCj4gLQkJCW1l
bWNweSgmYnRyZnNfYmlvKGJpbyktPnBhcmVudF9jaGVjaywNCj4gKwkJCW1lbWNweSgmYmJpby0+
cGFyZW50X2NoZWNrLA0KPiAgCQkJICAgICAgIGJpb19jdHJsLT5wYXJlbnRfY2hlY2ssDQo+ICAJ
CQkgICAgICAgc2l6ZW9mKHN0cnVjdCBidHJmc190cmVlX3BhcmVudF9jaGVjaykpOw0KPiAgCQl9
DQo+IC0JCWJpby0+Ymlfb3BmIHw9IFJFUV9NRVRBOw0KPiArCQliYmlvLT5iaW8uYmlfb3BmIHw9
IFJFUV9NRVRBOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChidHJmc19vcChiaW8pID09IEJUUkZTX01B
UF9SRUFEICYmDQo+ICsJaWYgKGJ0cmZzX29wKCZiYmlvLT5iaW8pID09IEJUUkZTX01BUF9SRUFE
ICYmDQo+ICAJICAgIGJpb19jdHJsLT5jb21wcmVzc190eXBlICE9IEJUUkZTX0NPTVBSRVNTX05P
TkUpDQo+IC0JCWJ0cmZzX3N1Ym1pdF9jb21wcmVzc2VkX3JlYWQoYnRyZnNfYmlvKGJpbyksIG1p
cnJvcl9udW0pOw0KPiArCQlidHJmc19zdWJtaXRfY29tcHJlc3NlZF9yZWFkKGJiaW8sIG1pcnJv
cl9udW0pOw0KPiAgCWVsc2UNCj4gLQkJYnRyZnNfc3VibWl0X2JpbyhidHJmc19iaW8oYmlvKSwg
bWlycm9yX251bSk7DQo+ICsJCWJ0cmZzX3N1Ym1pdF9iaW8oYmJpbywgbWlycm9yX251bSk7DQo+
ICANCj4gIAkvKiBUaGUgYmlvIGlzIG93bmVkIGJ5IHRoZSBlbmRfaW8gaGFuZGxlciBub3cgKi8N
CgkgICBUaGUgYmJpbz8gDQoNCg0KT3RoZXJ3aXNlLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=
