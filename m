Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49357B7A30
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbjJDIg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbjJDIg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 04:36:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D458A7;
        Wed,  4 Oct 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696408614; x=1727944614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q+Xt/HLk+OKydqPIRVtcysD1jMFFGA9koC1mY9OFRMc=;
  b=q5cR7iVwzx6arULUZ5AmJkW6SiizCt6ynS2NjrBvU1cfq88vuOXKIYYC
   uT8GQCtbOcurEvtiTTnwiKDBlBPjzHtAA7CeocuvruPMQx8Svyzw7uiyr
   YCO31Tg0YoXFlpGiLQh/FERNRmWdh+P7GplxYPaI+0Q/O2pYR8CmFU0eG
   XTXKXReswvrooBLudzNo3FObZRDJW67fnm9vfK+97wdZwJyXg7yfriz1c
   dCLxuS8llKGSWtOnWO9ktCEs/xm21Y9FAg6M3SvsiyjIvef934nIob+OX
   yHHuIRcK06BH5OawTHwGrBAMaJPDTQZxwHQ6MA/H0n66PFwovvQmmoPzR
   Q==;
X-CSE-ConnectionGUID: HGOVjh38RgWw/v2N2ONkSw==
X-CSE-MsgGUID: DvzRwnqbQfSgg3/RQ3Wn0Q==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="250131774"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 16:36:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw6WBwc421fU3aYfSOiJHyBXM1wjM9HGDYNYfGwqcoc3/KE9a3WjrzpC5HrbecLIg8AoiQdf7YPV77EI6kyCXPEPSh4DbuiAJjfoVqmYpR26va+4AStZftgeAiTKCa93BTme9y9+5hL8UmFJ452DTu9vecKDwinTF+BPiXUiQ1n0/fjCZHbRxohgFHVa9bfIGgXTiFs8fI1n1qIEAHucgwnnQt3Z+x+oyk9rbQV7/2HGYfndts4uxb6qHwRR7/BQZC+hmbrEppnRYIQnhCTJX2by91VsvPccXcQQnrG/uRY2TkBk2HPVuhqhN7CLTNO61NbxQAdgIaFWmkGdxjmiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+Xt/HLk+OKydqPIRVtcysD1jMFFGA9koC1mY9OFRMc=;
 b=NshUfqw7idSg8gDBXwoGGHDMUaAOirAYviTFYSa08AWQ/Tsb3vQ8CHN0lXFuI+CkMQNc73wvRs+DmtXDPzjkzkbxpY0abP6v1hRWwHTt1pnu3RiOj2IpQU6TlY1dKHkYihqdVEN6AnYUOgKPKneD04KudiVaD4l+xqhsTEhbqJEPFma5dLRBqBxw9YgK0fH/al86yVyCF0Q7XyDFeHGyenHEoI6VWwv+TxxC4caftpBkpAmPwAYJ23UU6DRi6+QkuEqKT8MeQDZEcobFVpoyBuRcE8PDyV56vMABoBRjUzUKFdoynYfc8DBI6aZDlaXWiBAa/uC3gQb/JbRxhZQR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+Xt/HLk+OKydqPIRVtcysD1jMFFGA9koC1mY9OFRMc=;
 b=E9BgppsJoodo0VWAuP5KyxxhpdqBO15IGLXWmaKNDd+7qFAe6v4VBFWl6XooXdpVrOh5+mwF2/ID7iv2HVlTxiXnaNl62j25GErMIqiIVIJ/waJ9lpMmk+yKXe1pxf1Kca7iKDyq4bLG2dKy9P1+DtY/PTXUG6Aye/D83jXLiEg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7075.namprd04.prod.outlook.com (2603:10b6:a03:223::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Wed, 4 Oct
 2023 08:36:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 08:36:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] btrfs: RAID stripe tree updates
Thread-Topic: [PATCH v3 0/4] btrfs: RAID stripe tree updates
Thread-Index: AQHZ9phIbkenwY2gaEaCxlh+OTou0bA5S42AgAADGAA=
Date:   Wed, 4 Oct 2023 08:36:50 +0000
Message-ID: <25ad10f2-14a9-497f-acc4-7b8b37981582@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
 <55caa26c-3448-492c-b139-32c756556b34@gmx.com>
In-Reply-To: <55caa26c-3448-492c-b139-32c756556b34@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7075:EE_
x-ms-office365-filtering-correlation-id: 01fe6711-788c-4898-5add-08dbc4b50e1a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRHT+WOJqd2n2XM0QIwAUMvHpio801WfSMm5bUwzmk2YsFS1TQsqob65MWXxNGbmEmv7ggZSjfO+UY5qnZQi8+q9qXprGYBisArj8Gvl31aSBD6UwAAW3YejDrsz5jTpA/5RlVnq99SOAedZLq0y6TiLVVtjhtibrvUQYIPe5RYDFNIq5IGKIrhCThIGCMZVzGI/twBvGcQDPY5Mn7a6Go80yuF94b5ztkhwYtymSAVy+STIIORg6OMnHuztawUiwT0vjZb7FL/YdexsD5WLCLTQhcZiTG0W+sRYc2VZ60iHuCCtYpUSFhejyzFc1BCFL5yk0tvenzYEuBB9xRlQwhXeHDBp+tUv9kTT2KBpfsgARb/4b7dbB2z7MbmebrM0oXbgRQyL7vKb+zPPibem2CtfbnINZlDtcok48dbH9UdrfVZPEumcEa+pb+is7LRULNEkhkW8l0/lRXPBo61cZAiCl02gq/LhN/ZoBh/IRBcm8SloU9JkxSh+6cDBOSpBlXYsJlNvc0th2PMRlDGRhoCtACh0lJ7Nv8dSSHUSoN+b/GrVM3xlrdSuMzUO5SM6m2tqdMXJB4NhstCZ8sZ1Ny3Rq33PeNcvVYWAtOhr/il1p071LKuiDxmpmDSMnwuIc5ztBJL/Bh2x0MQQ/HudcU08jYHBi0gqNlWe+QZ3fZVuhU/3+WOPthH4OnC+JzmV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(71200400001)(478600001)(15650500001)(5660300002)(2906002)(41300700001)(83380400001)(38100700002)(38070700005)(31696002)(86362001)(66946007)(91956017)(110136005)(316002)(66446008)(54906003)(66476007)(64756008)(76116006)(8936002)(8676002)(31686004)(66556008)(4326008)(53546011)(6486002)(6506007)(6512007)(82960400001)(122000001)(36756003)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0k2cmdLYUorbG1neTd2SGV6MzEwYkUwZll5WXBpODJtZFVPWW9xamdOOXo1?=
 =?utf-8?B?U1BpVHNVdHozS3lucVlXMTY5dFNaR3VZOTkyQXY3UWQyYW1ZbWVVRUpBMU1K?=
 =?utf-8?B?aUhtbGdROGJadHNxb2VtQTNXakNlN2hEcThpbWVEaGd2dk0zcTRNUVJzeWNN?=
 =?utf-8?B?Z0cwbFJyZGJOQmI2MDZHbEhSSS9GYVRCMUVqZ0s4QVRKTHM4cGxCTjNRQzh5?=
 =?utf-8?B?emdObXk4aENVMkk5RmRVOWREK0NmQXpZZHpzV0U4c0lEbjBteERHb1dkY0Fo?=
 =?utf-8?B?ZUdWU2hKSWtNSVRBY0t5T2JmSHBJWkJoeHg5OFdETXg2eGR5TnVMc1R2UXkr?=
 =?utf-8?B?MWF1cFFxUVZhTEl1cm1JendIalhrYmdjSTRTWWpodmppSi8yc1VsbFRhNGxp?=
 =?utf-8?B?RGZ4aEMwK0dsY25tOE5sTGFaQmdEQXR0dytKMmM4bzh2eDRCZWhPQzFmeHdj?=
 =?utf-8?B?RVN6clI5emZFdHhLZ0JWQmNzK1hIYlFyOXkvdVBoVWFoSHBvYi9vbnVvaEpC?=
 =?utf-8?B?N1pqcXA5Vm40VUo3M3V2TVpuSFY2QWUzWjByUnBUdDdQQ3pNSi8xWDFBSEcy?=
 =?utf-8?B?SGZiNVN6Mk14dXFNZHc5WXdINlNxNHpGdlN4dEUwZWh3NUtFdWpVV0FpbjhV?=
 =?utf-8?B?VWVXa1dPbXBUdys1NlZCN3JHSGZHU0FMVTFxU1hLQzBWeVlRc1ZXam5FYno2?=
 =?utf-8?B?OGZ6S0oraGZvOVBOU29UVWpTa093dVgvcUhhTEd1bUQyMzhMdGVDTkQ2N3Ro?=
 =?utf-8?B?cHF5MkxHM3JUWkp2TWVjMFp1YmExd3djZmd0R29IQzlYODhiQ1IrdGxxTzd5?=
 =?utf-8?B?VWxUSzF4TERkai9QVzM1QmNrajdXWkwxQzRPUUc5T29sNWVmeXFoK1dqZHFM?=
 =?utf-8?B?M2F3bTllWFgyOW44ZGtGRHVTVXNGZVRWSjVoYmdLcW8wV1JFMXZreUxubExQ?=
 =?utf-8?B?QlFKZlFaTCthMlpDbkVoVmFlY3h6d3RuYndtSk9UaE1HWkowMkk1NlhxUkYv?=
 =?utf-8?B?OUVVVEdYQlpoUnpnRlBkOXoyOXI4cGxIOVVhcm42cTA5WnY1NldyL2dvRTU3?=
 =?utf-8?B?aG9kLzJxTUFrdnppSk5hdnFzczRUQTlSeWJLWHNRV2FRemJYRUhCOStmNkxN?=
 =?utf-8?B?NzlnUTVuUnh2WStNRTB0dmVzUDFGVzVncm5RVFpGWjIvbmliRGl1NytaNlRN?=
 =?utf-8?B?OXhDTld6QVpjeTFhWXYweTg5aUI1amRKcS91UmVWRzlzWFgzVEgvYzVOVlpW?=
 =?utf-8?B?azdGMGFIRnQxRDZSMCtUQzRhVDlhS0pJZlBnYnhHSktDaDYzcExmRXZtS2NG?=
 =?utf-8?B?dkN2cE9MTlVxQlVHMCs0SHhPbVAzbitjTzFzMEJyRjBrd2V4QnJRRmF4Nm5E?=
 =?utf-8?B?YUljdjVtTDVvQTN2Y3BucklBdTRVTDlGZDRoUmhpSW5IWnpsS3dBamlNeVFx?=
 =?utf-8?B?U0Z3a1hsaExqUytOZ25wZkpla2dzSFJWTGMySi9ZY2ZZSEVpNW5zbnpXRFdR?=
 =?utf-8?B?aCtjRS9UY0FCbVFFT2NHREQ4SkJLY3dqdG5KaEJWbzB6NW5LOC9KRVJqR29H?=
 =?utf-8?B?QXpvTUh2QTZXK1o1cDFmL0Nua2lWU3g4RXU0ZGl1eXRLZHR6VG40WkdHOFJz?=
 =?utf-8?B?L1dnMmNmRytsUFBuTllmdGVhU0xmOUlCOGpUcVd4WVJHR1hkKzM2L1l0eUpC?=
 =?utf-8?B?bHRRTFBlRkJ5eit3RFJldXlqZXd6UzZjNlZrbitJZ1Eya3BrZ1BZaUE2SER5?=
 =?utf-8?B?bEdYVHo4ZnkwVmVkOWVSRmVTQ0dLUkI0MGVRQjJIcVNvY1pxTE9rYUdMUlRW?=
 =?utf-8?B?MWRPYmpkTzZpTjA2R2ZVNGt3NWRtS1J1cmZYQ25TVzY1dWdsdklCZDJITFZ2?=
 =?utf-8?B?eEErcmNEVkdzY3RDRXUwdGJiMjRCblhDNzVyZE5EYmtkZ3Y3QkhyTVVLcFd0?=
 =?utf-8?B?T0lSU295d2FPVTBFR3I0eGxHUE43UXRxWWUrOWNxYWlJOUQydlBHVmUxck9p?=
 =?utf-8?B?cElFamhteHdYVHM5czl5bGh5aVpJelIwVEp2b0hrQTBMMkk1UG9OV1A0Q2cz?=
 =?utf-8?B?dW42dFMyanNIMmdXVStEbVFYSXl0ZFlsenp0WUxrQlRrc3BGYy9WV2R6V3No?=
 =?utf-8?B?UlZRU1NCSFl3UGdtY0dmQkF4dmRGd0JRV05WWHNPVWFybW01dnk0U0kxUVdC?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <079FB079641D59439B09A0550E1D9007@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ixcmp81A6ucvGVvJ2PTpK4rQk5Y/XUN77XjRY5DijwKicWBak1AAOLBuZ/b0B2b+RzfBtUu8/S+maBqhUMzmTImaGdsDoGMQzi+VE+fR7BCAHF6F5JBWHPCGDQBfXV9TSK1oKvsypy9i8mw9XOyqW90DS3xZBBRokj9oKRu3qeha3LyWb1oU8gmf7mkM+W+ssoNQibdPH992Jy5bvf7EDjOFSjIsxodfY0rHQDFS1udYOb8hf2Mp74fWeEwXvJUtDKNmg8CcThbgY2fNZyQD9ahV/aLX5okylu6lOoJc74xKDh+S+ZDnpj7yjv4OfomsgI7VJOdRiJP5UKFtuF2gGMbzhWJ7ZfRX93OSfAPCFuV3Sn9tAa3L7hFEqNyBliGFVSxycpVY25q3P+So1hS3eheLYgpFlHx3mck2yOAxMSFgj60txxzA5CoNvBxmmEW2mcN0YB7xgKJ5YlWMg22Oq4fFYB8n5jjgh0AdkUwawGjoBiGqdxKq0f1wc2HhlF9XGrzOWAZmJ6lOn8HdUtnqRSc+4MdVvD+pJc3Xt3QV9M8z3YZDWebzQGsMxywrllbRzLRxkGm3Rsz8/HLs6rRqm0mbcq1WIAfwexHw8au08PpVHA9kgO3pgmpWUtknMQlhg+ehOsYQaRmpzA49GhaBUwYV013P7IZu2rCs3ol7wtk7i4O3sCstEDQWAiMgrK5hxCtF7zr5SLSd9zydtCzNThqLe6icNO5KI/CEiseBbyuwLW+583LJy5qwsmnj1RslMC9AIjC581mySGo3PQivoeYV8WO4e0xn6wllwOPE6Ab60CEwbrRP75D0WXukwYhLv7AQoC6ecC0m63FK6kedt6BRWfMSZbU3R1RO7ElBwPjg4Ra5ePZZG+RAQufG7w93Tlba92vzR7E7oBrdtaF74rLJ4xdqkkzfYiN7LpzylUQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fe6711-788c-4898-5add-08dbc4b50e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 08:36:50.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba0dOAvF4DUOdVIH7OSOlW+HYi5QQ9LZKwD02eawvSS/z9NQvqLpT7HAi0Mv9hGapkJUShFAzGnI8dwgpCTz2u8shpah2wuPgcfVPEG3ve4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDQuMTAuMjMgMTA6MjYsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzEw
LzQgMTg6MjYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IFRoaXMgYmF0Y2ggb2YgUlNU
IHVwZGF0ZXMgY29udGFpbnMgdGhlIG9uLWRpc2sgZm9ybWF0IGNoYW5nZXMgUXUNCj4+IHN1Z2dl
c3RlZC4gSXQgZHJhc3RpY2FsbHkgc2ltcGxpZmllcyB0aGUgd3JpdGUgYW5kIHBhdGgsIGVzcGVj
aWFsbHkgZm9yDQo+PiBSQUlEMTAuDQo+Pg0KPj4gSW5zdGVhZCBvZiByZWNvcmRpbmcgYWxsIHN0
cmlkZXMgb2YgYSBzdHJpcGVkIFJBSUQgaW50byBvbmUgc3RyaXBlIHRyZWUNCj4+IGVudHJ5LCB3
ZSBjcmVhdGUgbXVsdGlwbGUgZW50cmllcyBwZXIgc3RyaWRlLiBUaGlzIGFsbG93cyB1cyB0byBy
ZW1vdmUgdGhlDQo+PiBsZW5ndGggaW4gdGhlIHN0cmlkZSBhcyB3ZSBjYW4gdXNlIHRoZSBsZW5n
dGggZnJvbSB0aGUga2V5LiBVc2luZyB0aGlzDQo+PiBtZXRob2QgUkFJRDEwIGJlY29tZXMgUkFJ
RDEgYW5kIFJBSUQwIGJlY29tZXMgc2luZ2xlIGZyb20gdGhlIHBvaW50IG9mDQo+PiB2aWV3IG9m
IHRoZSBzdHJpcGUgdHJlZS4NCj4gDQo+IEdyZWF0IHRoZSBpZGVhIGNhbiBzaW1wbGlmeSB0aGUg
Y29kZS4NCj4gU28gSSdtIHZlcnkgZ2xhZCBJIGNhbiBwcm92aWRlIHNvbWUgaGVscCBvbiBSU1Qu
DQo+IA0KPiBBbHRob3VnaCBvbmUgY29uY2VybiBpcyBhYm91dCB0aGUgY29tcGF0aWJpbGl0eSwg
YnV0IEkgZ3Vlc3Mgc2luY2UgcnN0DQo+IGlzIHN0aWxsIGNvdmVyZWQgdW5kZXIgZXhwZXJpbWVu
dGFsIGZsYWdzIGZvciBwcm9ncywgd2UgY2FuIG1vcmUgb3IgbGVzcw0KPiBpZ25vcmUgdGhlIGNv
bXBhdGliaWxpdHkgZm9yIG5vdz8NCg0KVGhleSdyZSBvbmx5IGluIG1pc2MtbmV4dCBieSBub3cg
c28gSSBob3BlIHdlIGNhbi4NCg0KPiBUaGUgb3RoZXIgY29uY2VybiBpcywgaG93IHdvdWxkIHRo
b3NlIHBhdGNoZXMgYmUgbWVyZ2VkLCB3b3VsZCBEYXZpZA0KPiBqdXN0IGZvbGQgdGhlbSwgYW5k
IHdlIGNhbiBjaGVjayB0aGUgbWlzYy1uZXh0LCBvciB0aGVyZSB3b3VsZCBiZQ0KPiBhbm90aGVy
IGJyYW5jaCBmb3IgdXMgdG8gdmlldyB0aGUgY29kZT8NCg0KSSB3YXMgdW5kZXIgdGhlIGltcHJl
c3Npb24sIERhdmlkIGlzIGdvaW5nIHRvIGZvbGQgdGhlbSBpbi4NCg==
