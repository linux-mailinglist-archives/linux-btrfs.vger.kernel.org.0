Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD754F8B01
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 02:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiDGWf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiDGWf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 18:35:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683366CA6
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 15:33:24 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48768 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1ncags-00049r-Cp by authid <merlins.org> with srv_auth_plain; Thu, 07 Apr 2022 15:33:22 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1ncags-00HQqY-7G; Thu, 07 Apr 2022 15:33:22 -0700
Date:   Thu, 7 Apr 2022 15:33:22 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220407223322.GK3307770@merlins.org>
References: <11970220.O9o76ZdvQC@ananda>
 <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org>
 <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
 <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 07, 2022 at 06:09:53PM -0400, Josef Bacik wrote:
> Just following up on this, I've got hungry kids, I'm about halfway
> through the new shit.  Depending on how much help kids need with
> homework I may have this done later tonight, or it'll be tomorrow
> morning.  Thanks,

it's stlil churning along and looping. I have no idea if it's
converging, or not.


parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x56055fb76600
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
FS_INFO AFTER IS 0x56055fb76600
Couldn't find a replacement block for slot 178
Couldn't find a replacement block for slot 206
Couldn't find a replacement block for slot 62
fixed slot 88
fixed slot 235
fixed slot 237
Couldn't find a replacement block for slot 238
Couldn't find a replacement block for slot 243
fixed slot 33
fixed slot 35
fixed slot 32
fixed slot 133
fixed slot 136
fixed slot 207
Couldn't find a replacement block for slot 221
Couldn't find a replacement block for slot 484
Couldn't find a replacement block for slot 76
fixed slot 229
fixed slot 172
fixed slot 174
fixed slot 36
Couldn't find a replacement block for slot 20
fixed slot 24
Couldn't find a replacement block for slot 28
fixed slot 115
fixed slot 148
fixed slot 9
Couldn't find a replacement block for slot 318
fixed slot 245
fixed slot 1
Couldn't find a replacement block for slot 153
Couldn't find a replacement block for slot 121
Couldn't find a replacement block for slot 134
fixed slot 159
fixed slot 170
fixed slot 204
fixed slot 149
fixed slot 185
fixed slot 257
fixed slot 46
fixed slot 60
fixed slot 91
fixed slot 92
fixed slot 95
fixed slot 247
fixed slot 105
Couldn't find a replacement block for slot 109
fixed slot 124
fixed slot 191
fixed slot 244
fixed slot 9
fixed slot 57
Couldn't find a replacement block for slot 166
fixed slot 163
fixed slot 78
fixed slot 179
Couldn't find a replacement block for slot 50
Couldn't find a replacement block for slot 218
fixed slot 26
fixed slot 75
Couldn't find a replacement block for slot 68
fixed slot 56
fixed slot 60
Couldn't find a replacement block for slot 231
fixed slot 141
fixed slot 151
fixed slot 156
fixed slot 159
fixed slot 163
fixed slot 171
fixed slot 200
fixed slot 5
Couldn't find a replacement block for slot 157
fixed slot 224
fixed slot 44
fixed slot 217
fixed slot 122
fixed slot 59
Couldn't find a replacement block for slot 120
fixed slot 181
fixed slot 187
Couldn't find a replacement block for slot 46
Couldn't find a replacement block for slot 33
Couldn't find a replacement block for slot 220
fixed slot 60
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 192
fixed slot 9
fixed slot 7
Couldn't find a replacement block for slot 226
fixed slot 24
fixed slot 49
fixed slot 22
Couldn't find a replacement block for slot 186
fixed slot 149
fixed slot 150
Couldn't find a replacement block for slot 42
fixed slot 218
fixed slot 223
fixed slot 228
fixed slot 230
fixed slot 233
fixed slot 234
fixed slot 240
fixed slot 155
fixed slot 24
fixed slot 30
fixed slot 376
fixed slot 94
fixed slot 104
fixed slot 197
Couldn't find a replacement block for slot 91
Couldn't find a replacement block for slot 191
fixed slot 139
fixed slot 128
Couldn't find a replacement block for slot 143
fixed slot 16
fixed slot 17
fixed slot 114
fixed slot 28
Couldn't find a replacement block for slot 86
Couldn't find a replacement block for slot 83
fixed slot 86
fixed slot 92
fixed slot 149
fixed slot 117
Couldn't find a replacement block for slot 31
fixed slot 188
Couldn't find a replacement block for slot 102
Couldn't find a replacement block for slot 23
Couldn't find a replacement block for slot 203
Couldn't find a replacement block for slot 79
Couldn't find a replacement block for slot 180
Couldn't find a replacement block for slot 21
Couldn't find a replacement block for slot 167
Couldn't find a replacement block for slot 276
Couldn't find a replacement block for slot 282
Couldn't find a replacement block for slot 283
Couldn't find a replacement block for slot 284
Couldn't find a replacement block for slot 285
Couldn't find a replacement block for slot 286
Couldn't find a replacement block for slot 287
Couldn't find a replacement block for slot 289
Couldn't find a replacement block for slot 290
Couldn't find a replacement block for slot 291
Couldn't find a replacement block for slot 69
Couldn't find a replacement block for slot 231
fixed slot 208
Couldn't find a replacement block for slot 171
Couldn't find a replacement block for slot 116
Couldn't find a replacement block for slot 74
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 208
Couldn't find a replacement block for slot 89
Couldn't find a replacement block for slot 243
Couldn't find a replacement block for slot 199
Couldn't find a replacement block for slot 130
fixed slot 138
fixed slot 33
Couldn't find a replacement block for slot 179
fixed slot 154
Couldn't find a replacement block for slot 256
Couldn't find a replacement block for slot 214
Couldn't find a replacement block for slot 190
Couldn't find a replacement block for slot 129
fixed slot 111
Couldn't find a replacement block for slot 103
Couldn't find a replacement block for slot 192
fixed slot 12
Couldn't find a replacement block for slot 205
fixed slot 24
fixed slot 28
fixed slot 31
fixed slot 38
fixed slot 47
fixed slot 62
fixed slot 75
fixed slot 86
fixed slot 89
fixed slot 93
fixed slot 108
Couldn't find a replacement block for slot 115
fixed slot 146
fixed slot 218
fixed slot 288
fixed slot 33
Couldn't find a replacement block for slot 106
Couldn't find a replacement block for slot 176
fixed slot 240
Couldn't find a replacement block for slot 241
fixed slot 34
fixed slot 35
Couldn't find a replacement block for slot 71
Couldn't find a replacement block for slot 140
fixed slot 213
Couldn't find a replacement block for slot 155
fixed slot 210
fixed slot 111
fixed slot 147
fixed slot 150
Couldn't find a replacement block for slot 234
Couldn't find a replacement block for slot 236
fixed slot 240
fixed slot 250
Couldn't find a replacement block for slot 259
fixed slot 269
fixed slot 283
Couldn't find a replacement block for slot 43
Couldn't find a replacement block for slot 48
fixed slot 135
fixed slot 192
fixed slot 206
fixed slot 43
fixed slot 111
Couldn't find a replacement block for slot 172
Couldn't find a replacement block for slot 45
fixed slot 47
fixed slot 212
fixed slot 49
fixed slot 190
fixed slot 4
fixed slot 40
fixed slot 110
fixed slot 227
fixed slot 290
fixed slot 296
fixed slot 297
fixed slot 302
fixed slot 349
fixed slot 357
Couldn't find a replacement block for slot 53
fixed slot 304
Couldn't find a replacement block for slot 328
fixed slot 376
fixed slot 54
fixed slot 125
fixed slot 195
Couldn't find a replacement block for slot 89
fixed slot 177
fixed slot 197
Couldn't find a replacement block for slot 219
fixed slot 233
fixed slot 36
fixed slot 52
fixed slot 61
fixed slot 71
fixed slot 113
fixed slot 119
fixed slot 138
Couldn't find a replacement block for slot 153
Couldn't find a replacement block for slot 200
fixed slot 215
Couldn't find a replacement block for slot 173
fixed slot 315
fixed slot 320
fixed slot 326
fixed slot 328
fixed slot 335
fixed slot 65
fixed slot 32
Couldn't find a replacement block for slot 33
Couldn't find a replacement block for slot 34
Couldn't find a replacement block for slot 37
fixed slot 40
Couldn't find a replacement block for slot 179
fixed slot 75
fixed slot 198
fixed slot 79
fixed slot 16
fixed slot 89
fixed slot 111
fixed slot 152
fixed slot 219
fixed slot 220
fixed slot 43
fixed slot 70
fixed slot 85
fixed slot 102
fixed slot 130
fixed slot 145
fixed slot 146
fixed slot 161
fixed slot 188
fixed slot 202
Couldn't find a replacement block for slot 9
fixed slot 62
fixed slot 122
fixed slot 128
fixed slot 137
fixed slot 142
fixed slot 216
Couldn't find a replacement block for slot 26
fixed slot 143
fixed slot 152
fixed slot 174
fixed slot 185
fixed slot 76
fixed slot 87
fixed slot 26
fixed slot 28
fixed slot 31
fixed slot 33
fixed slot 35
fixed slot 43
fixed slot 46
fixed slot 47
fixed slot 56
fixed slot 62
fixed slot 69
fixed slot 73
fixed slot 76
fixed slot 78
fixed slot 81
fixed slot 83
fixed slot 90
fixed slot 92
fixed slot 93
fixed slot 94
fixed slot 98
fixed slot 110
fixed slot 113
fixed slot 114
fixed slot 115
fixed slot 117
fixed slot 118
fixed slot 119
fixed slot 120
fixed slot 121
fixed slot 122
fixed slot 125
fixed slot 142
fixed slot 146
fixed slot 147
fixed slot 148
fixed slot 179
fixed slot 182
fixed slot 185
fixed slot 101
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 89
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 136
Couldn't find a replacement block for slot 228
Couldn't find a replacement block for slot 109
Couldn't find a replacement block for slot 430
Couldn't find a replacement block for slot 190
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 41
fixed slot 63
fixed slot 33
fixed slot 36
Couldn't find a replacement block for slot 47
fixed slot 52
fixed slot 58
Couldn't find a replacement block for slot 426
Couldn't find a replacement block for slot 64
Couldn't find a replacement block for slot 66
Couldn't find a replacement block for slot 223
fixed slot 76
Couldn't find a replacement block for slot 53
Couldn't find a replacement block for slot 92
fixed slot 228
Couldn't find a replacement block for slot 109
Couldn't find a replacement block for slot 122
Couldn't find a replacement block for slot 172
Couldn't find a replacement block for slot 173
Couldn't find a replacement block for slot 245
fixed slot 153
Couldn't find a replacement block for slot 115
Couldn't find a replacement block for slot 193
Couldn't find a replacement block for slot 239
Couldn't find a replacement block for slot 240
Couldn't find a replacement block for slot 241
fixed slot 125
Couldn't find a replacement block for slot 98
Couldn't find a replacement block for slot 185
fixed slot 200
fixed slot 202
Couldn't find a replacement block for slot 203
fixed slot 204
Couldn't find a replacement block for slot 103
fixed slot 249
Couldn't find a replacement block for slot 250
fixed slot 284
fixed slot 305
fixed slot 128
fixed slot 144
Couldn't find a replacement block for slot 342
fixed slot 164
fixed slot 204
fixed slot 58
fixed slot 132
Couldn't find a replacement block for slot 161
fixed slot 177
fixed slot 209
Couldn't find a replacement block for slot 117
Couldn't find a replacement block for slot 248
Couldn't find a replacement block for slot 2
Couldn't find a replacement block for slot 96
fixed slot 5
fixed slot 114
Couldn't find a replacement block for slot 90
fixed slot 237
fixed slot 19
fixed slot 7
Couldn't find a replacement block for slot 27
fixed slot 48
fixed slot 53
Couldn't find a replacement block for slot 45
Couldn't find a replacement block for slot 225
fixed slot 50
Couldn't find a replacement block for slot 52
fixed slot 57
fixed slot 208
fixed slot 210
fixed slot 78
fixed slot 230
fixed slot 61
Couldn't find a replacement block for slot 81
Couldn't find a replacement block for slot 178
Couldn't find a replacement block for slot 174
fixed slot 96
fixed slot 63
fixed slot 113
Couldn't find a replacement block for slot 144
Couldn't find a replacement block for slot 26
Couldn't find a replacement block for slot 53
fixed slot 78
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 174
fixed slot 182
Couldn't find a replacement block for slot 183
fixed slot 184
Couldn't find a replacement block for slot 185
fixed slot 199
Couldn't find a replacement block for slot 201
Couldn't find a replacement block for slot 213
fixed slot 215
Couldn't find a replacement block for slot 106
Couldn't find a replacement block for slot 111
Couldn't find a replacement block for slot 113
Couldn't find a replacement block for slot 120
Couldn't find a replacement block for slot 124
fixed slot 125
Couldn't find a replacement block for slot 127
Couldn't find a replacement block for slot 139
fixed slot 140
Couldn't find a replacement block for slot 148
Couldn't find a replacement block for slot 150
Couldn't find a replacement block for slot 156
Couldn't find a replacement block for slot 166
fixed slot 179
fixed slot 186
fixed slot 111
fixed slot 0
Couldn't find a replacement block for slot 9
Couldn't find a replacement block for slot 15
Couldn't find a replacement block for slot 44
fixed slot 49
Couldn't find a replacement block for slot 67
fixed slot 68
fixed slot 69
fixed slot 70
fixed slot 76
fixed slot 80
fixed slot 83
Couldn't find a replacement block for slot 86
fixed slot 113
fixed slot 140
fixed slot 143
fixed slot 144
fixed slot 184
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 194
Couldn't find a replacement block for slot 195
Couldn't find a replacement block for slot 196
fixed slot 197
Couldn't find a replacement block for slot 198
Couldn't find a replacement block for slot 199
fixed slot 202
Couldn't find a replacement block for slot 203
fixed slot 205
Couldn't find a replacement block for slot 215
Couldn't find a replacement block for slot 239
fixed slot 245
fixed slot 247
fixed slot 248
fixed slot 260
fixed slot 20
fixed slot 28
fixed slot 44
fixed slot 45
Couldn't find a replacement block for slot 48
Couldn't find a replacement block for slot 57
Couldn't find a replacement block for slot 61
Couldn't find a replacement block for slot 69
fixed slot 82
Couldn't find a replacement block for slot 86
fixed slot 90
Couldn't find a replacement block for slot 92
fixed slot 96
Couldn't find a replacement block for slot 97
fixed slot 110
fixed slot 116
fixed slot 121
fixed slot 138
fixed slot 150
fixed slot 158
fixed slot 160
fixed slot 162
Couldn't find a replacement block for slot 168
Couldn't find a replacement block for slot 169
Couldn't find a replacement block for slot 170
Couldn't find a replacement block for slot 171
Couldn't find a replacement block for slot 173
fixed slot 175
fixed slot 179
fixed slot 181
Couldn't find a replacement block for slot 182
fixed slot 185
Couldn't find a replacement block for slot 186
Couldn't find a replacement block for slot 187
Couldn't find a replacement block for slot 188
fixed slot 193
fixed slot 205
fixed slot 215
Couldn't find a replacement block for slot 224
fixed slot 233
fixed slot 237
fixed slot 243
fixed slot 256
Couldn't find a replacement block for slot 11
Couldn't find a replacement block for slot 15
fixed slot 21
fixed slot 26
Couldn't find a replacement block for slot 32
fixed slot 50
fixed slot 55
Couldn't find a replacement block for slot 57
fixed slot 112
fixed slot 113
fixed slot 114
Couldn't find a replacement block for slot 121
Couldn't find a replacement block for slot 122
Couldn't find a replacement block for slot 123
Couldn't find a replacement block for slot 127
fixed slot 131
Couldn't find a replacement block for slot 140
fixed slot 146
Couldn't find a replacement block for slot 153
fixed slot 154
Couldn't find a replacement block for slot 159
fixed slot 163
fixed slot 164
fixed slot 177
fixed slot 202
fixed slot 214
Couldn't find a replacement block for slot 220
fixed slot 230
Couldn't find a replacement block for slot 246
fixed slot 251
Couldn't find a replacement block for slot 259
Couldn't find a replacement block for slot 261
Couldn't find a replacement block for slot 262
Couldn't find a replacement block for slot 263
fixed slot 264
fixed slot 266
fixed slot 114
fixed slot 5
fixed slot 24
fixed slot 72
fixed slot 85
fixed slot 93
fixed slot 98
Couldn't find a replacement block for slot 111
fixed slot 128
fixed slot 130
Couldn't find a replacement block for slot 131
fixed slot 133
fixed slot 145
fixed slot 146
Couldn't find a replacement block for slot 75
Couldn't find a replacement block for slot 76
Couldn't find a replacement block for slot 77
Couldn't find a replacement block for slot 83
Couldn't find a replacement block for slot 141
Couldn't find a replacement block for slot 186
Couldn't find a replacement block for slot 187
Couldn't find a replacement block for slot 36
Couldn't find a replacement block for slot 37
Couldn't find a replacement block for slot 38
fixed slot 111
fixed slot 118
fixed slot 119
fixed slot 206
Couldn't find a replacement block for slot 226
Couldn't find a replacement block for slot 228
Couldn't find a replacement block for slot 229
Couldn't find a replacement block for slot 231
Couldn't find a replacement block for slot 374
Couldn't find a replacement block for slot 376
fixed slot 377
Couldn't find a replacement block for slot 60
fixed slot 122
Couldn't find a replacement block for slot 92
fixed slot 96
Couldn't find a replacement block for slot 170
Couldn't find a replacement block for slot 171
Couldn't find a replacement block for slot 172
Couldn't find a replacement block for slot 178
Couldn't find a replacement block for slot 180
fixed slot 126
Couldn't find a replacement block for slot 119
Couldn't find a replacement block for slot 120
Couldn't find a replacement block for slot 121
Couldn't find a replacement block for slot 122
Couldn't find a replacement block for slot 123
Couldn't find a replacement block for slot 124
Couldn't find a replacement block for slot 125
Couldn't find a replacement block for slot 128
Couldn't find a replacement block for slot 129
Couldn't find a replacement block for slot 130
Couldn't find a replacement block for slot 131
Couldn't find a replacement block for slot 132
Couldn't find a replacement block for slot 136
Couldn't find a replacement block for slot 140
Couldn't find a replacement block for slot 141
fixed slot 129
fixed slot 134
Couldn't find a replacement block for slot 100
fixed slot 101
Couldn't find a replacement block for slot 138
Couldn't find a replacement block for slot 139
Couldn't find a replacement block for slot 35
Couldn't find a replacement block for slot 36
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 367
Couldn't find a replacement block for slot 136
Couldn't find a replacement block for slot 243
Couldn't find a replacement block for slot 244
Couldn't find a replacement block for slot 308
Couldn't find a replacement block for slot 309
Couldn't find a replacement block for slot 310
Couldn't find a replacement block for slot 311
Couldn't find a replacement block for slot 312
Couldn't find a replacement block for slot 326
Couldn't find a replacement block for slot 138
Couldn't find a replacement block for slot 49
fixed slot 13
Couldn't find a replacement block for slot 80
Couldn't find a replacement block for slot 145
Couldn't find a replacement block for slot 76
fixed slot 143
Couldn't find a replacement block for slot 28
fixed slot 159
Couldn't find a replacement block for slot 114
Couldn't find a replacement block for slot 124
Couldn't find a replacement block for slot 126
fixed slot 148
Couldn't find a replacement block for slot 150
fixed slot 155
fixed slot 161
Couldn't find a replacement block for slot 203
Couldn't find a replacement block for slot 204
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 211
Couldn't find a replacement block for slot 214
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 220
Couldn't find a replacement block for slot 221
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 243
Couldn't find a replacement block for slot 254
Couldn't find a replacement block for slot 199
fixed slot 161
Couldn't find a replacement block for slot 108
Couldn't find a replacement block for slot 110
Couldn't find a replacement block for slot 111
Couldn't find a replacement block for slot 116
Couldn't find a replacement block for slot 159
Couldn't find a replacement block for slot 175
Couldn't find a replacement block for slot 184
Couldn't find a replacement block for slot 203
Couldn't find a replacement block for slot 205
Couldn't find a replacement block for slot 206
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 263
fixed slot 169
Couldn't find a replacement block for slot 18
Couldn't find a replacement block for slot 43
Couldn't find a replacement block for slot 49
Couldn't find a replacement block for slot 51
Couldn't find a replacement block for slot 111
Couldn't find a replacement block for slot 124
Couldn't find a replacement block for slot 138
fixed slot 157
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 170
Couldn't find a replacement block for slot 207
fixed slot 210
fixed slot 212
fixed slot 213
fixed slot 216
fixed slot 219
Couldn't find a replacement block for slot 235
fixed slot 242
fixed slot 243
fixed slot 244
Couldn't find a replacement block for slot 245
Couldn't find a replacement block for slot 269
fixed slot 170
Couldn't find a replacement block for slot 28
Couldn't find a replacement block for slot 46
Couldn't find a replacement block for slot 125
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 250
Couldn't find a replacement block for slot 254
Couldn't find a replacement block for slot 257
Couldn't find a replacement block for slot 265
Couldn't find a replacement block for slot 279
Couldn't find a replacement block for slot 280
Couldn't find a replacement block for slot 281
Couldn't find a replacement block for slot 4
Couldn't find a replacement block for slot 9
fixed slot 37
Couldn't find a replacement block for slot 40
Couldn't find a replacement block for slot 68
Couldn't find a replacement block for slot 74
Couldn't find a replacement block for slot 82
Couldn't find a replacement block for slot 90
Couldn't find a replacement block for slot 113
Couldn't find a replacement block for slot 114
fixed slot 115
Couldn't find a replacement block for slot 116
Couldn't find a replacement block for slot 117
Couldn't find a replacement block for slot 118
fixed slot 127
Couldn't find a replacement block for slot 135
Couldn't find a replacement block for slot 144
Couldn't find a replacement block for slot 167
Couldn't find a replacement block for slot 179
Couldn't find a replacement block for slot 181
Couldn't find a replacement block for slot 199
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 219
Couldn't find a replacement block for slot 221
Couldn't find a replacement block for slot 222
Couldn't find a replacement block for slot 235
Couldn't find a replacement block for slot 239
Couldn't find a replacement block for slot 241
Couldn't find a replacement block for slot 242
Couldn't find a replacement block for slot 264
Couldn't find a replacement block for slot 265
Couldn't find a replacement block for slot 267
fixed slot 16
Couldn't find a replacement block for slot 23
Couldn't find a replacement block for slot 26
Couldn't find a replacement block for slot 41
fixed slot 44
Couldn't find a replacement block for slot 52
fixed slot 55
Couldn't find a replacement block for slot 66
Couldn't find a replacement block for slot 97
Couldn't find a replacement block for slot 98
fixed slot 100
Couldn't find a replacement block for slot 118
Couldn't find a replacement block for slot 123
Couldn't find a replacement block for slot 125
fixed slot 150
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 191
Couldn't find a replacement block for slot 198
Couldn't find a replacement block for slot 207
Couldn't find a replacement block for slot 208
fixed slot 211
fixed slot 213
Couldn't find a replacement block for slot 218
fixed slot 221
Couldn't find a replacement block for slot 231
fixed slot 248
Couldn't find a replacement block for slot 255
Couldn't find a replacement block for slot 256
fixed slot 173
Couldn't find a replacement block for slot 4
Couldn't find a replacement block for slot 5
fixed slot 28
Couldn't find a replacement block for slot 29
Couldn't find a replacement block for slot 30
fixed slot 31
fixed slot 39
Couldn't find a replacement block for slot 41
fixed slot 55
Couldn't find a replacement block for slot 78
Couldn't find a replacement block for slot 84
Couldn't find a replacement block for slot 98
Couldn't find a replacement block for slot 99
fixed slot 102
Couldn't find a replacement block for slot 114
Couldn't find a replacement block for slot 126
Couldn't find a replacement block for slot 128
Couldn't find a replacement block for slot 138
Couldn't find a replacement block for slot 139
Couldn't find a replacement block for slot 140
Couldn't find a replacement block for slot 180
Couldn't find a replacement block for slot 182
Couldn't find a replacement block for slot 184
Couldn't find a replacement block for slot 209
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 211
Couldn't find a replacement block for slot 213
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 222
Couldn't find a replacement block for slot 223
Couldn't find a replacement block for slot 224
Couldn't find a replacement block for slot 225
Couldn't find a replacement block for slot 226
Couldn't find a replacement block for slot 227
Couldn't find a replacement block for slot 229
Couldn't find a replacement block for slot 230
Couldn't find a replacement block for slot 231
Couldn't find a replacement block for slot 233
Couldn't find a replacement block for slot 252
Couldn't find a replacement block for slot 253
Couldn't find a replacement block for slot 254
fixed slot 256
Couldn't find a replacement block for slot 11
fixed slot 28
Couldn't find a replacement block for slot 33
fixed slot 39
Couldn't find a replacement block for slot 63
Couldn't find a replacement block for slot 72
fixed slot 119
Couldn't find a replacement block for slot 146
fixed slot 156
Couldn't find a replacement block for slot 179
Couldn't find a replacement block for slot 182
Couldn't find a replacement block for slot 190
Couldn't find a replacement block for slot 193
Couldn't find a replacement block for slot 194
Couldn't find a replacement block for slot 197
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 240
Couldn't find a replacement block for slot 241
Couldn't find a replacement block for slot 250
Couldn't find a replacement block for slot 252
Couldn't find a replacement block for slot 5
Couldn't find a replacement block for slot 13
Couldn't find a replacement block for slot 18
Couldn't find a replacement block for slot 31
Couldn't find a replacement block for slot 53
Couldn't find a replacement block for slot 56
Couldn't find a replacement block for slot 57
Couldn't find a replacement block for slot 62
Couldn't find a replacement block for slot 84
Couldn't find a replacement block for slot 85
Couldn't find a replacement block for slot 86
Couldn't find a replacement block for slot 87
fixed slot 99
Couldn't find a replacement block for slot 100
Couldn't find a replacement block for slot 101
fixed slot 108
fixed slot 141
fixed slot 155
fixed slot 178
Couldn't find a replacement block for slot 181
Couldn't find a replacement block for slot 197
fixed slot 177
fixed slot 193
Couldn't find a replacement block for slot 194
Couldn't find a replacement block for slot 195
fixed slot 226
Couldn't find a replacement block for slot 273
fixed slot 302
Couldn't find a replacement block for slot 69
Couldn't find a replacement block for slot 70
Couldn't find a replacement block for slot 143
Couldn't find a replacement block for slot 144
fixed slot 204
Couldn't find a replacement block for slot 129
Couldn't find a replacement block for slot 130
Couldn't find a replacement block for slot 254
Couldn't find a replacement block for slot 255
Couldn't find a replacement block for slot 214
fixed slot 248
fixed slot 220
fixed slot 204
Couldn't find a replacement block for slot 205
Couldn't find a replacement block for slot 206
Couldn't find a replacement block for slot 207
Couldn't find a replacement block for slot 210
Couldn't find a replacement block for slot 211
Couldn't find a replacement block for slot 215
Couldn't find a replacement block for slot 220
fixed slot 234
Couldn't find a replacement block for slot 235
fixed slot 236
Couldn't find a replacement block for slot 247
Couldn't find a replacement block for slot 248
Couldn't find a replacement block for slot 267
fixed slot 276
fixed slot 288
Couldn't find a replacement block for slot 317
fixed slot 330
Couldn't find a replacement block for slot 337
Couldn't find a replacement block for slot 345
Couldn't find a replacement block for slot 346
fixed slot 361
Couldn't find a replacement block for slot 365
Couldn't find a replacement block for slot 366
Couldn't find a replacement block for slot 369
Couldn't find a replacement block for slot 370
Couldn't find a replacement block for slot 372
Couldn't find a replacement block for slot 373
fixed slot 379
Couldn't find a replacement block for slot 380
Couldn't find a replacement block for slot 381
Couldn't find a replacement block for slot 382
Couldn't find a replacement block for slot 387
Couldn't find a replacement block for slot 388
Couldn't find a replacement block for slot 389
Couldn't find a replacement block for slot 390
Couldn't find a replacement block for slot 394
fixed slot 395
Couldn't find a replacement block for slot 396
fixed slot 407
Couldn't find a replacement block for slot 408
Couldn't find a replacement block for slot 410
Couldn't find a replacement block for slot 411
Couldn't find a replacement block for slot 412
Couldn't find a replacement block for slot 425
Couldn't find a replacement block for slot 426
Couldn't find a replacement block for slot 427
Couldn't find a replacement block for slot 428
fixed slot 221
fixed slot 0
Couldn't find a replacement block for slot 1
Couldn't find a replacement block for slot 2
Couldn't find a replacement block for slot 8
Couldn't find a replacement block for slot 13
Couldn't find a replacement block for slot 15
Couldn't find a replacement block for slot 16
Couldn't find a replacement block for slot 17
Couldn't find a replacement block for slot 20
Couldn't find a replacement block for slot 36
Couldn't find a replacement block for slot 38
Couldn't find a replacement block for slot 48
Couldn't find a replacement block for slot 49
Couldn't find a replacement block for slot 50
Couldn't find a replacement block for slot 54
Couldn't find a replacement block for slot 55
Couldn't find a replacement block for slot 56
fixed slot 67
fixed slot 83
Couldn't find a replacement block for slot 84
Couldn't find a replacement block for slot 119
Couldn't find a replacement block for slot 122
Couldn't find a replacement block for slot 123
Couldn't find a replacement block for slot 126
fixed slot 206
Couldn't find a replacement block for slot 207
Couldn't find a replacement block for slot 220
fixed slot 224
fixed slot 143
fixed slot 158
Couldn't find a replacement block for slot 159
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 199
Couldn't find a replacement block for slot 204
Couldn't find a replacement block for slot 227
Couldn't find a replacement block for slot 228
fixed slot 229
fixed slot 225
fixed slot 95
fixed slot 104
Couldn't find a replacement block for slot 105
Couldn't find a replacement block for slot 125
Couldn't find a replacement block for slot 131
Couldn't find a replacement block for slot 141
Couldn't find a replacement block for slot 163
Couldn't find a replacement block for slot 165
fixed slot 171
Couldn't find a replacement block for slot 182
Couldn't find a replacement block for slot 184
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 203
fixed slot 205
Couldn't find a replacement block for slot 213
Couldn't find a replacement block for slot 215
fixed slot 221
Couldn't find a replacement block for slot 225
fixed slot 226
fixed slot 231
Couldn't find a replacement block for slot 240
Couldn't find a replacement block for slot 241
Couldn't find a replacement block for slot 242
fixed slot 243
fixed slot 254
Couldn't find a replacement block for slot 255
Couldn't find a replacement block for slot 257
Couldn't find a replacement block for slot 258
Couldn't find a replacement block for slot 229
fixed slot 233
Couldn't find a replacement block for slot 147
Couldn't find a replacement block for slot 153
Couldn't find a replacement block for slot 154
fixed slot 155
Couldn't find a replacement block for slot 182
Couldn't find a replacement block for slot 183
Couldn't find a replacement block for slot 187
Couldn't find a replacement block for slot 188
Couldn't find a replacement block for slot 190
Couldn't find a replacement block for slot 191
Couldn't find a replacement block for slot 192
Couldn't find a replacement block for slot 193
Couldn't find a replacement block for slot 201
Couldn't find a replacement block for slot 228
Couldn't find a replacement block for slot 233
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 240
Couldn't find a replacement block for slot 242
Couldn't find a replacement block for slot 1
Couldn't find a replacement block for slot 2
Couldn't find a replacement block for slot 3
Couldn't find a replacement block for slot 4
Couldn't find a replacement block for slot 12
Couldn't find a replacement block for slot 13
Couldn't find a replacement block for slot 14
Couldn't find a replacement block for slot 19
Couldn't find a replacement block for slot 22
fixed slot 45
Couldn't find a replacement block for slot 46
Couldn't find a replacement block for slot 47
Couldn't find a replacement block for slot 48
Couldn't find a replacement block for slot 54
Couldn't find a replacement block for slot 59
Couldn't find a replacement block for slot 61
Couldn't find a replacement block for slot 76
Couldn't find a replacement block for slot 78
fixed slot 81
Couldn't find a replacement block for slot 85
Couldn't find a replacement block for slot 87
fixed slot 90
Couldn't find a replacement block for slot 91
Couldn't find a replacement block for slot 92
fixed slot 94
Couldn't find a replacement block for slot 104
fixed slot 170
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 208
fixed slot 210
fixed slot 218
Couldn't find a replacement block for slot 256
Couldn't find a replacement block for slot 271
fixed slot 235
fixed slot 14
Couldn't find a replacement block for slot 15
Couldn't find a replacement block for slot 16
Couldn't find a replacement block for slot 17
Couldn't find a replacement block for slot 24
Couldn't find a replacement block for slot 25
Couldn't find a replacement block for slot 233
fixed slot 245
Couldn't find a replacement block for slot 246
Couldn't find a replacement block for slot 247
Couldn't find a replacement block for slot 248
Couldn't find a replacement block for slot 249
Couldn't find a replacement block for slot 285
fixed slot 286
Couldn't find a replacement block for slot 287
fixed slot 49
Couldn't find a replacement block for slot 53
fixed slot 63
Couldn't find a replacement block for slot 67
Couldn't find a replacement block for slot 68
Couldn't find a replacement block for slot 70
fixed slot 78
Couldn't find a replacement block for slot 101
Couldn't find a replacement block for slot 102
fixed slot 105
Couldn't find a replacement block for slot 114
fixed slot 122
Couldn't find a replacement block for slot 123
Couldn't find a replacement block for slot 131
Couldn't find a replacement block for slot 133
Couldn't find a replacement block for slot 142
Couldn't find a replacement block for slot 144
Couldn't find a replacement block for slot 154
Couldn't find a replacement block for slot 155
fixed slot 179
fixed slot 196
fixed slot 199
Couldn't find a replacement block for slot 225
Couldn't find a replacement block for slot 259
Couldn't find a replacement block for slot 260
Couldn't find a replacement block for slot 261
fixed slot 29
Couldn't find a replacement block for slot 136
Couldn't find a replacement block for slot 206
Couldn't find a replacement block for slot 209
Couldn't find a replacement block for slot 429
fixed slot 289
Couldn't find a replacement block for slot 195
fixed slot 172
Couldn't find a replacement block for slot 173
Couldn't find a replacement block for slot 295
fixed slot 4
fixed slot 7
Couldn't find a replacement block for slot 11
Couldn't find a replacement block for slot 14
Couldn't find a replacement block for slot 15
fixed slot 16
Couldn't find a replacement block for slot 35
Couldn't find a replacement block for slot 36
Couldn't find a replacement block for slot 38
Couldn't find a replacement block for slot 40
Couldn't find a replacement block for slot 41
Couldn't find a replacement block for slot 46
Couldn't find a replacement block for slot 47
Couldn't find a replacement block for slot 48
fixed slot 49
Couldn't find a replacement block for slot 154
Couldn't find a replacement block for slot 253
fixed slot 7
Couldn't find a replacement block for slot 189
Couldn't find a replacement block for slot 191
Couldn't find a replacement block for slot 62
Couldn't find a replacement block for slot 63
Couldn't find a replacement block for slot 168
fixed slot 172
Couldn't find a replacement block for slot 180
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 186
Couldn't find a replacement block for slot 203
Couldn't find a replacement block for slot 214
fixed slot 267
fixed slot 268
Couldn't find a replacement block for slot 269
Couldn't find a replacement block for slot 270
Couldn't find a replacement block for slot 280
fixed slot 281
Couldn't find a replacement block for slot 282
fixed slot 13
Couldn't find a replacement block for slot 30
Couldn't find a replacement block for slot 31
Couldn't find a replacement block for slot 69
fixed slot 70
Couldn't find a replacement block for slot 90
Couldn't find a replacement block for slot 111
Couldn't find a replacement block for slot 130
Couldn't find a replacement block for slot 146
Couldn't find a replacement block for slot 147
Couldn't find a replacement block for slot 156
fixed slot 173
Couldn't find a replacement block for slot 174
Couldn't find a replacement block for slot 175
Couldn't find a replacement block for slot 185
Couldn't find a replacement block for slot 188
Couldn't find a replacement block for slot 209
Couldn't find a replacement block for slot 220
Couldn't find a replacement block for slot 221
fixed slot 229
Couldn't find a replacement block for slot 230
Couldn't find a replacement block for slot 231
Couldn't find a replacement block for slot 233
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 239
Couldn't find a replacement block for slot 241
Couldn't find a replacement block for slot 244
fixed slot 3
fixed slot 4
Couldn't find a replacement block for slot 5
Couldn't find a replacement block for slot 7
Couldn't find a replacement block for slot 8
Couldn't find a replacement block for slot 9
Couldn't find a replacement block for slot 13
Couldn't find a replacement block for slot 14
Couldn't find a replacement block for slot 15
Couldn't find a replacement block for slot 16
Couldn't find a replacement block for slot 17
Couldn't find a replacement block for slot 18
fixed slot 25
Couldn't find a replacement block for slot 28
Couldn't find a replacement block for slot 40
fixed slot 41
Couldn't find a replacement block for slot 42
Couldn't find a replacement block for slot 43
Couldn't find a replacement block for slot 44
Couldn't find a replacement block for slot 47
Couldn't find a replacement block for slot 55
fixed slot 60
Couldn't find a replacement block for slot 61
Couldn't find a replacement block for slot 63
Couldn't find a replacement block for slot 66
Couldn't find a replacement block for slot 73
Couldn't find a replacement block for slot 74
fixed slot 78
Couldn't find a replacement block for slot 80
Couldn't find a replacement block for slot 82
Couldn't find a replacement block for slot 92
Couldn't find a replacement block for slot 93
Couldn't find a replacement block for slot 99
fixed slot 103
Couldn't find a replacement block for slot 104
Couldn't find a replacement block for slot 106
fixed slot 109
Couldn't find a replacement block for slot 110
fixed slot 111
fixed slot 120
Couldn't find a replacement block for slot 121
fixed slot 125
Couldn't find a replacement block for slot 126
Couldn't find a replacement block for slot 127
Couldn't find a replacement block for slot 128
fixed slot 301
Couldn't find a replacement block for slot 19
fixed slot 22
fixed slot 28
Couldn't find a replacement block for slot 29
Couldn't find a replacement block for slot 30
fixed slot 31
Couldn't find a replacement block for slot 38
Couldn't find a replacement block for slot 39
fixed slot 48
Couldn't find a replacement block for slot 51
fixed slot 53
Couldn't find a replacement block for slot 55
Couldn't find a replacement block for slot 56
fixed slot 62
fixed slot 77
Couldn't find a replacement block for slot 78
Couldn't find a replacement bl (waiting for more output)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
